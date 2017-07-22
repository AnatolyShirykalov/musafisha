export default class NextPrev {
  constructor() {
    $(document).keydown((e)=>{
      let loc = (window.location.pathname)
      let div = $(".nextprev")
      if (!div) return
      switch(e.key){
        case 'ArrowLeft':
          Turbolinks.visit(div.data("previous"))
          break;
        case 'ArrowRight':
          Turbolinks.visit(div.data("next"))
          break;
      }
    })
  }
}
