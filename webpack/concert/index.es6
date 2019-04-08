import './_index.sass'
import ymap from "ymap"
import Loadmore from 'loadmore'
export default class Concert {
  constructor(){
    new Loadmore('#next_concerts', '.card');
    
    if(this.noneed()) return;
    this.wait().then(()=>{
      //this.ymap = this.defaultMap()
      //this.div.addClass('done')
      //let adds = this.addresses()
      //this.addObjects(adds)
      //this.center(adds)
    })
  }
  defaultCoords(){
    return [55.76, 37.64]
  }
  wait(){
    return new Promise((resolve, reject)=>{
      ymap.load().then(()=>{
        ymaps.ready(()=>{
          $.waitForCss('#map', {opacity: 0.99}).then(()=> resolve())
        })
      })
    })
  }
  noneed(){
    this.div = $('#map')
    if(this.div.length==0 || this.div.hasClass('done')) return true;
    return false
  }
  defaultMap(){
    return new ymaps.Map("map", {center: this.defaultCoords(), zoom: 10 })
  }
  addresses(){
    let ar = this.div.data('array');
    if (!ar) console.error("No array in #map");
    if (!ar) return [{geometry: {type: 'Point', coordinates: this.defaultCoords()}}];
    return ar.map((a)=>{
      return {
        geometry: {type: 'Point', coordinates:  [a.lat, a.lon]},
        properties: {
          hintContent: a.name,
          balloonContentHeader: a.name,
          balloonContentBody: a.addr,
        },
      }
    })
  }
  addObjects(adds){
    adds.forEach((ad)=>this.ymap.geoObjects.add(new ymaps.GeoObject(ad)))
  }
  center(adds){
    if (adds.length == 1) {
      return this.ymap.setCenter(adds[0].coords, 5, {
        checkZoomRange: true
      })
    }
    this.ymap.setBounds(this.ymap.geoObjects.getBounds())
  }
}
