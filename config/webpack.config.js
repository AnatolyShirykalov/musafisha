'use strict';

var fs = require('fs');
var path = require('path');
var webpack = require('webpack');
var ManifestPlugin = require('webpack-manifest-plugin');

var CompressionPlugin = require("compression-webpack-plugin");

//const { UnusedFilesWebpackPlugin } = require("unused-files-webpack-plugin");

/**
 * PostCSS plugins
 */
const postCssCssNano = require('cssnano');
const postCssAutoprefixer = require('autoprefixer');
const postCssUrl = require('postcss-url');
const postCssPresetEnv = require('postcss-preset-env');
const postCssFlexBugsFixes = require('postcss-flexbugs-fixes');


var host = process.env.WEBPACK_HOST || process.env.HOST || 'localhost';
var devServerPort = process.env.WEBPACK_PORT || 3808;

var production = process.env.NODE_ENV === 'production';

const ExtractCssChunks = require("extract-css-chunks-webpack-plugin")
class CleanUpExtractCssChunks {
  shouldPickStatChild(child) {
    return child.name.indexOf('extract-css-chunks-webpack-plugin') !== 0;
  }

  apply(compiler) {
    compiler.hooks.done.tap('CleanUpExtractCssChunks', (stats) => {
      const children = stats.compilation.children;
      if (Array.isArray(children)) {
        // eslint-disable-next-line no-param-reassign
        stats.compilation.children = children
          .filter(child => this.shouldPickStatChild(child));
      }
    });
  }
}

var config = {
  mode: production ? "production" : "development",
  //mode: "development",
  entry: {
    // Sources are expected to live in $app_root
    //vendor: [],
    application: 'application.es6',
  },

  module: {
      rules: [
          { test: /\.es6/, use: "babel-loader" },
          { test: /\.jsx$/, use: "babel-loader" },
          { test: /\.handlebars$/, use: 'handlebars-loader'},
          { test: /\.pug/, use: 'pug-loader'},
          {
            test: /\.woff($|\?)|\.woff2($|\?)|\.ttf($|\?)|\.eot($|\?)/,
            use: 'file-loader'
          },
          { test: /\.(jpe?g|png|gif)$/i, use: "file-loader" },
          {
            test: /\.r\.svg$/i,

            use: [{
              loader: '@svgr/webpack',
              options: {
                svgoConfig: {
                  plugins: {
                    removeViewBox: false
                  }
                }
              }
            }]
          },
          {
            test: /pdf\.worker\.min\.js$/,
            use: "file-loader"
          },
          {
            test: /\.svg$/i,
            exclude: [
              /inline/i,
              /\.r\.svg$/i
            ],
            use: "file-loader"
          },
          {
            test: /\.(sass|scss|css)$/,
            use: [
              {
                loader: ExtractCssChunks.loader,
                options: {
                  hot: !production,
                }
              },
              {
                loader: "css-loader",
                options: {
                  //minimize: true,
                  sourceMap: true
                }
              },
              {
                loader: 'postcss-loader',
                options: {
                  sourceMap: true,
                  plugins: ((() => {
                    const plugins = [];
                    plugins.push(
                      postCssFlexBugsFixes(),
                      postCssPresetEnv(),
                      postCssUrl(),
                      postCssAutoprefixer(),
                    );
                    if (production) {
                      plugins.push(
                        postCssCssNano(),
                      );
                    }
                    return plugins;
                  })()),
                },
              },
              {
                loader: "sass-loader",
                options: {
                  sourceMap: true,
                }
              }
            ]
          },
      ]
  },

  output: {
    // Build assets directly in to public/webpack/, let webpack know
    // that all webpacked assets start with webpack/

    // must match config.webpack.output_dir
    path: path.join(__dirname, "..", "public", "webpack"),
    publicPath: '/webpack/',

    filename: production ? '[name]-[chunkhash].js' : '[name].js',
    chunkFilename: production ? '[name]-[chunkhash].js' : '[name].js',
  },

  resolve: {
    modules: [
      path.resolve(__dirname, "..", "webpack"),
      path.resolve(__dirname, "..", "node_modules")
    ],
    extensions: [".es6", ".jsx", ".js", ".sass", ".scss", ".css", ".svg", ".png", ".jpg"],
    alias: {
      '~': path.resolve(__dirname, "..", "webpack"),
    }
  },

  plugins: [
    new ExtractCssChunks({
      // Options similar to the same options in webpackOptions.output
      // both options are optional
      filename: production ? "[name]-[chunkhash].css" : "[name].css",
      chunkfilename: production ? "[name]-[id].css" : "[name].css",
    }),
    new CleanUpExtractCssChunks(),
    new ManifestPlugin({
      writeToFileEmit: true,
      publicPath: production ? "/webpack/" : 'http://' + host + ':' + devServerPort + '/webpack/',
    }),
    new webpack.ProvidePlugin({
      $: "jquery",
      jQuery: "jquery",
      Popper: ['popper.js', 'default'],
      Alert: "exports-loader?Alert!bootstrap/js/dist/alert",
      Button: "exports-loader?Button!bootstrap/js/dist/button",
    })
  ],
  optimization: {
    runtimeChunk: { name: 'vendor' },
    splitChunks: {
      chunks: "initial",
      cacheGroups: {
        default: false,
        vendors: {
          chunks: "initial",
          test: /[\\/]node_modules[\\/]/,
          priority: -10,
          name: "vendor",
        },
      },
    },
  },
};

if (production) {
  config.plugins.push(
    new webpack.ContextReplacementPlugin(/moment[/\\]locale$/, /ru/),
    new webpack.DefinePlugin({ // <--key to reduce React's size
      'process.env': {
        NODE_ENV: JSON.stringify('production'),
        NO_CABLE: process.env.NO_CABLE ? JSON.stringify(true) : JSON.stringify(false)
      }
    }),
    new CompressionPlugin({
        //asset: "[path].gz",
        algorithm: "gzip",
        test: /\.js$|\.css$/,
        threshold: 4096,
        minRatio: 0.8
    })
  );
  config.output.publicPath = '/webpack/';
} else {
  config.plugins.push(
    new webpack.NamedModulesPlugin(),
    new webpack.DefinePlugin({
      'process.env': {
        NO_CABLE: process.env.NO_CABLE ? JSON.stringify(true) : JSON.stringify(false),
      }
    })
  );

  config.devServer = {
    port: devServerPort,
    disableHostCheck: true,
    headers: { 'Access-Control-Allow-Origin': '*' },
  };
  config.output.publicPath = 'http://' + host + ':' + devServerPort + '/webpack/';
  // Source maps
  config.devtool = 'source-map';
}

module.exports = config;

