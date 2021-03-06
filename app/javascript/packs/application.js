/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

console.log('Hello World from Webpacker')
import TurbolinksAdapter from 'vue-turbolinks';
import Vue from 'vue/dist/vue.esm'

import axios from 'axios'

import ListingSearch from '../components/Search.vue'
import AppNotifications from '../components/Notifications.vue'
import DataTable  from '../components/DataTable.vue'

Vue.use(TurbolinksAdapter)

window.axios = axios;
let token = document.head.querySelector('meta[name="csrf-token"]');

if (token) {
    window.axios.defaults.headers.common['X-CSRF-TOKEN'] = token.content;
} else {
    console.error('CSRF token not found: ');
}

document.addEventListener('turbolinks:load', () => {
  const app = new Vue({
    el: '#app',
    data: {
      message: "Can you say hello?"
    },
    components: { AppNotifications, ListingSearch, DataTable }
  })
})