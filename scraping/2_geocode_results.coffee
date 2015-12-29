request = require("request")
jsonfile = require('jsonfile')
util = require('util')
_ = require('lodash')
Q = require('q')
 
infile = './50pageresults.json'
outfile = infile + '.geocoded.json'

googleGeocodeURL = "https://maps.googleapis.com/maps/api/geocode/json?address=ADDRESS&key=AIzaSyC6tmM3pNOmubnbXB9YK3Hsr3nsABT2clw"

webcams = {}

jsonfile.readFile infile, (err, obj) ->

    Q
        .all(obj.map geocodeLookup)
        .then (d) ->
            webcams = {}
            for o in d
                webcams[o.title] = o
            console.log webcams 

            jsonfile.writeFile outfile, webcams, {spaces: 2}, (err) ->
                console.error(err)
            

                result.then(geocodeLookup(o)).delay(150).


geocodeLookup = (o) ->
    d = Q.defer()
    address = o.location.replace(/[ ]/g, "+")
    u = googleGeocodeURL.replace(/ADDRESS/, address)

    request {
        url: u
        json: true
    }, (error, response, body) ->

        if (!error && response.statusCode == 200)
            try
                loc = body.results[0].geometry.location
                o.lat = loc.lat
                o.lng = loc.lng
                d.resolve(o)
            catch e 
                console.log "ERROR==="
                console.log u
                console.log e
                console.log body
                d.resolve()
    return d.promise;

