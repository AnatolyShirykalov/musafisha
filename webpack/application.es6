//import 'font-awesome/css/font-awesome.css';
import 'application.sass';
import 'rails-ujs';
import Errors from 'errors';
import 'flash';
import 'bootstrap';
import 'vendor/waitforcss'

import NextPrev from 'nextprev'
import Concert from 'concert'
import Visits from 'visits'

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
      new Visits(); break;
  }
})

