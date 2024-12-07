// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import "bootstrap"


import { Loader } from "@googlemaps/js-api-loader";

const loader = new Loader({
  apiKey: "<%= ENV['GOOGLE_MAPS_API_KEY'] %>",
  version: "weekly",
});

loader.load().then(() => {
  const map = new google.maps.Map(document.getElementById("map"), {
    center: { lat: -34.397, lng: 150.644 },
    zoom: 8,
  });
});


document.addEventListener("DOMContentLoaded", () => {
    const loader = new Loader({
      apiKey: "<%= ENV['GOOGLE_MAPS_API_KEY'] %>",
      version: "weekly",
    });
  
    loader.load().then(() => {
      const map = new google.maps.Map(document.getElementById("map"), {
        center: { lat: -34.397, lng: 150.644 },
        zoom: 8,
      });
    });
  });
  