import Loadmore from 'loadmore'
export default class Visits {
  initFull(){
    this.initLoadmore();
    this.initStateUpdater();
  }
  initLoadmore(){
    new Loadmore('#next_visits', '.card');
  }
  initStateUpdater(){
    $('.aasm').click((e)=>{
      let t = $(e.target)
      t.parent().children().attr('disabled', true);
      this.send({id: t.data('id'), event: t.data('event')}).then((r)=>{
        if (r.error) return console.error(r);
        t.parent().parent().parent().html(r);
        this.initStateUpdater();
      }).catch((e)=>{
        t.parent().children().removeAttr('disabled');
        console.error(e);
      })
    })
  }
  send(data){
    return new Promise((resolve, reject)=> $.ajax({
      url: "/visits/set",
      type: "POST",
      data: data,
      success: resolve,
      error: reject,
    }))
  }
}
