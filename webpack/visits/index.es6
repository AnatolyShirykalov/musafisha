import tmpl from "./visit.handlebars"
export default class Visits {
  constructor(){
    $('.aasm').click((e)=>{
      let t = $(e.target)
      this.send({id: t.data('id'), event: t.data('event')}).then((r)=>{
        if (r.error) return console.error(r)
        t.parent().html(r.events.map((e)=>tmpl(e)))
      }).catch(console.error)
    })
  }
  send(data){
    return new Promise((resolve, reject)=> $.ajax({
      url: "/visits/set",
      type: "POST",
      dataType: 'json',
      data: data,
      success: resolve,
      error: reject,
    }))
  }
}
