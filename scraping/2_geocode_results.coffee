request = require("request")
jsonfile = require('jsonfile')
util = require('util')
_ = require('lodash')
Q = require('q')
 
file = './results.json'

googleGeocodeURL = "https://maps.googleapis.com/maps/api/geocode/json?address=ADDRESS&key=AIzaSyC6tmM3pNOmubnbXB9YK3Hsr3nsABT2clw"

webcams = {}


jsonfile.readFile file, (err, obj) ->
    Q
        .all(obj[..2].map geocodeLookup)
        .then (d) ->
            console.log(d)



geocodeLookup = (o) ->
    d = Q.defer()
    address = o.location.replace(/[ ]/g, "+")
    u = googleGeocodeURL.replace(/ADDRESS/, address)

    request {
        url: u
        json: true
    }, (error, response, body) ->

        if (!error && response.statusCode == 200)
            loc = body.results[0].geometry.location
            webcam = {}
            webcam[o.title] = o
            webcam[o.title]['lat'] = loc.lat
            webcam[o.title]['lng'] = loc.lng
            d.resolve(webcam)

    return d.promise;

"""
jsonfile.readFile file, (err, obj) ->
    for o in obj[..2]
        address = o.location.replace(/[ ]/g, "+")
        u = googleGeocodeURL.replace(/ADDRESS/, address)

        ((url, o) ->
            request {
                url: url,
                json: true
            }, (error, response, body) ->

                if (!error && response.statusCode == 200)
                    loc = body.results[0].geometry.location
                    webcams[o.title] = o
                    webcams[o.title]['lat'] = loc.lat
                    webcams[o.title]['lng'] = loc.lng
        )(u, o)

        console.log webcams
"""

