'use strict';

var path = require('path');
var webpack = require('webpack');
var functions = require('postcss-functions');
var StatsPlugin = require('stats-webpack-plugin');

var ExtractTextPlugin = require("extract-text-webpack-plugin");

var autoprefixer = require('autoprefixer');
var CompressionPlugin = require("compression-webpack-plugin");

var host = process.env.HOST || 'localhost'
var devServerPort = 3808;

var production = process.env.NODE_ENV === 'production';

const extractSass = new ExtractTextPlugin({
    filename: "[name].[contenthash].css",
    disable: !production
});

//console.log("dir:", __dirname)

var sassExtractor = () => {
  return extractSass.extract({
    use: [{
      loader: "css-loader",
      options: {
        sourceMap: true
      }
    }, {
      loader: "sass-loader",
      options: {
        sourceMap: true
      }
    }],
    fallback: "style-loader"
  })
}

var config = {
  entry: {
    // Sources are expected to live in $app_root/webpack
    vendor: [
      'babel-polyfill',
      'axios',
      'jquery',
      'lodash',
    ],
    application: 'application.es6'
  },

  module: {
      rules: [
          { test: /\.es6/, use: "babel-loader" },
          { test: /\.handlebars$/, use: "handlebars-loader" },
          { test: /\.(jpe?g|png|gif)$/i, use: "file-loader" },
          {
            test: /\.woff($|\?)|\.woff2($|\?)|\.ttf($|\?)|\.eot($|\?)|\.svg($|\?)/,
            use: production ? 'file-loader' : 'url-loader'
          },
          { test: /\.sass$/, use: sassExtractor() },
          { test: /\.scss$/, use: sassExtractor() },
          { test: /\.css$/, use: sassExtractor() }
      ]
  },

  output: {
    // Build assets directly in to public/webpack/, let webpack know
    // that all webpacked assets start with webpack/

    // must match config.webpack.output_dir
    path: path.join(__dirname, '..', 'public', 'webpack'),
    publicPath: '/webpack/',

    filename: production ? '[name]-[chunkhash].js' : '[name].js'
  },

  resolve: {
    modules: [path.resolve(__dirname, "..", "webpack"), path.resolve(__dirname, "..", "node_modules")],
    extensions: [".js", ".es6", ".css", ".sass", ".scss"],
  },

  plugins: [
    extractSass,
    new StatsPlugin('manifest.json', {
      chunkModules: false,
      source: false,
      chunks: false,
      modules: false,
      assets: true
    }),
    new webpack.ProvidePlugin({
      $: "jquery/dist/jquery",
      jQuery: "jquery/dist/jquery",
      "window.jQuery": "jquery/dist/jquery",
      //Tether: "tether",
      //"window.Tether": "tether",
      "_": "lodash",
      "window._": "lodash",
      //Alert: "exports-loader?Alert!bootstrap/js/dist/alert",
      //Button: "exports-loader?Button!bootstrap/js/dist/button",
    })
  ]
};

if (production) {
  config.plugins.push(
    new webpack.optimize.CommonsChunkPlugin({name: 'vendor', filename: 'vendor-[chunkhash].js'}),
    new webpack.optimize.UglifyJsPlugin({
      compressor: { warnings: false },
      sourceMap: false
    }),
    new webpack.DefinePlugin({ // <--key to reduce React's size
      'process.env': { NODE_ENV: JSON.stringify('production') }
    }),
    new webpack.optimize.ModuleConcatenationPlugin(),
    new CompressionPlugin({
        asset: "[path].gz",
        algorithm: "gzip",
        test: /\.js$|\.css$/,
        threshold: 4096,
        minRatio: 0.8
    })
  );
} else {
  config.plugins.push(
    new webpack.optimize.CommonsChunkPlugin({name: 'vendor', filename: 'vendor.js'}),
    new webpack.NamedModulesPlugin()
  )

  config.devServer = {
    port: devServerPort,
    headers: { 'Access-Control-Allow-Origin': '*' },
  };
  config.output.publicPath = 'http://' + host + ':' + devServerPort + '/webpack/';
  config.devtool = 'source-map';
}

module.exports = config;


