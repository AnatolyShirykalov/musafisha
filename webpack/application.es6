//import 'font-awesome/css/font-awesome.css';
import 'application.sass';
import 'rails-ujs';
import Errors from 'errors';
import 'flash';
import 'bootstrap';
import 'vendor/waitforcss'

import NextPrev from 'nextprev'
import Concert from 'pages/concert'

window.A = {}
A.errors = new Errors()

new NextPrev()
$(function() {
  A.errors.checkCookie();
});

import Turbolinks from "turbolinks";
Turbolinks.start()

document.addEventListener("turbolinks:load", function() {
  new Concert()
})

