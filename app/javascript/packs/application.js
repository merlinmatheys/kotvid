// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import 'bootstrap';

// CSS
// import { initMapbox } from '../plugins/init_mapbox';
// document.addEventListener('turbolinks:load', () => {
//   initMapbox();
// })
import { initMapbox } from '../plugins/init_mapbox';

document.addEventListener('turbolinks:load', () => {
  initMapbox();
})

// export { initMapbox };

// import mapboxgl from 'mapbox-gl'
// document.getElementById('map')
// const mapElement = document.getElementById('map');

// // console.log(document.getElementById('map'))

// mapboxgl.accessToken = 'pk.eyJ1IjoiZGlhbXMiLCJhIjoiY2s5M3kyNDdrMDR6cjNlbnkzamdmampmYyJ9.4qspABqw_4cIFzI74SviOQ';
// // mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
// const map = new mapboxgl.Map({
//   container: 'map',
//   style: 'mapbox://styles/mapbox/streets-v11'
// });


// const markers = JSON.parse(mapElement.dataset.markers);
// markers.forEach((marker) => {
//   new mapboxgl.Marker()
//     .setLngLat([ marker.lng, marker.lat ])
//     .addTo(map);
// });


// import 'mapbox-gl/dist/mapbox-gl.css';
// internal imports

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
