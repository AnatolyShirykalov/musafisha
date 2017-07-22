var isLoaded = false;
var isLoading = false;

var defer = function() {
  var result = {};
  result.promise = new Promise(function(resolve, reject) {
      result.resolve = resolve;
      result.reject = reject;
  });
  return result;
}

var dfd = defer();

var mapSrc = "https://api-maps.yandex.ru/2.1/?lang=ru_RU&onload=ymapLoaded";

function ymapLoad(){
  if (isLoaded || isLoading) {
    return dfd.promise;
  }

  isLoading = true;
  var scr = document.createElement('script');
  scr.setAttribute("type", "text/javascript");
  scr.setAttribute("src", mapSrc);
  (document.getElementsByTagName("head")[0] || document.documentElement).appendChild(scr);
  return dfd.promise;
}

window.ymapLoaded = function() {
  isLoaded = true;
  dfd.resolve();
}

export default {
  load: ymapLoad,
  promise: dfd.promise,
  isLoaded: isLoaded,
  isLoading: isLoading
}
