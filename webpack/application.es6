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
import './tags'
import 'magnific-popup';
import 'magnific-popup/dist/magnific-popup.css';

document.addEventListener("turbolinks:load", (event)=> {
  $('.js-concert-image').magnificPopup({
      type: 'image',
      image: {
        verticalFit: false,
      },
      closeOnContentClick: true,
    })
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
import axios from "axios";
axios.defaults.headers.common["X-CSRF-Token"] = document.querySelector(
  "meta[name=csrf-token]"
).content;
axios.defaults.headers.common["X-Requested-With"] = "XMLHttpRequest";
