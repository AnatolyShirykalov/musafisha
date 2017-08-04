import Loadmore from 'loadmore'
export default class Decisions {
  constructor(){
    new Loadmore('#next_decisions', '.card');
  }
}

