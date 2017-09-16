import 'font-awesome/css/font-awesome.css';
import 'application.sass';
import Rails from 'rails-ujs';
Rails.start()
import Errors from 'errors';
import 'flash';
import 'bootstrap';
import 'vendor/waitforcss'

window.Popper = Popper
import NextPrev from 'nextprev'
import Concert from 'concert'
import Visits from 'visits'
import Decisions from 'decisions'

window.A = {}
A.errors = new Errors()
window.$ = $
new NextPrev()
$(function() {
  A.errors.checkCookie();
});

import Turbolinks from "turbolinks";
Turbolinks.start()

document.addEventListener("turbolinks:load", (event)=> {
  switch ($('.page-data').data('controller')){
    case 'concerts':
      new Concert(); break;
    case 'visits':
      new Visits($('.page-data').data('action')).initFull(); break;
    case 'decisions':
      new Visits($('.page-data').data('action')).initStateUpdater();
      new Decisions();
      break;
  }
})

