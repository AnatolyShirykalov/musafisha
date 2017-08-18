import Loadmore from 'loadmore'
export default class Visits {
  constructor(action){
    this.action = action;
  }
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
      t.closest('.row').find('button').attr('disabled', true);
      this.send({
        id: t.data('id'),
        event: t.data('event'),
        full: this.action == 'show',
      }).then((r)=>{
        if (r.error) return console.error(r);
        t.closest('.row').parent().parent().replaceWith(r);
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
