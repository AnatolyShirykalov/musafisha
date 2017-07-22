$.waitForCss = function(selector, props) {
  return new Promise((resolve, reject) => {
    var ok = true;
    $.each(props, (k, v) => {
      //console.log(k, v);
      var css = $(selector).eq(0).css(k)
      if (css != v) {
        //console.log("not ok", this, css, v)
        ok = false;
      }
    });
    if (!ok) {
      //console.log("wait for css");
      setTimeout(() => {
        $.waitForCss(selector, props).then(resolve)
      }, 200)
    } else {
      resolve()
    }
  })
}
