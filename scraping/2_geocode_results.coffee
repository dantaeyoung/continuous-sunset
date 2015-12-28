var $ = require('./jquery');

url = "https://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&key=AIzaSyC6tmM3pNOmubnbXB9YK3Hsr3nsABT2clw"

$.getJSON url, (json) ->
    console.log json
