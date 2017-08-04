export default class Loadmore {
  constructor(nextDomId, itemClass){
    this.nextDomId = nextDomId;
    this.itemClass = itemClass;
    this.initLoadMore()
    $(document).on('click', `${this.nextDomId} a`, (event) =>{
      event.preventDefault(); this.loadMore();
    })
  }
  loadMore(){
    let $t = $(this.nextDomId);
    if (!$t || $t.hasClass('loading')) return;
    $t.addClass('loading')
    let $a = $t.find('a')
    if ($a.length > 0) {
      $.ajax({
        url: $a.attr('href'),
        success: (data) => {
          $t.replaceWith(data)
          this.initLoadMore()
          $(document).trigger('load_more')
        },
        error: ()=> {
          $t.removeClass('loading')
        },
      })
    }
  }
  initLoadMore(){
    $(window).off('scroll.load_ext');
    if ($(this.nextDomId).length > 0) {
      let checkLoadMore = () => {
        let top = $(this.itemClass).map(function(k, e){return $(e).offset().top}).sort(function(a,b){return b-a})[0];
        let max = $(window).scrollTop() + $(window).height();
        if (top < max + 200) this.loadMore();
      }
      $(window).on('scroll.load_ext', checkLoadMore);
      checkLoadMore();
    }
  }
}
