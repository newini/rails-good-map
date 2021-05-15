// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// Bootstrap
import 'bootstrap'

// Plotly.js
// https://classic.yarnpkg.com/en/package/plotly.js-basic-dist
var Plotly = require('plotly.js-dist')
global.Plotly = Plotly
console.log('Plotly.js. version: ' + Plotly.version)
