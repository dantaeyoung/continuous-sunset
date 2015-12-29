request = require("request")
jsonfile = require('jsonfile')
util = require('util')
_ = require('lodash')
finish = require("finish")

 
infile = './50pageresults.json'
outfile = infile + '.geocoded.json'

googleGeocodeURL = "https://maps.googleapis.com/maps/api/geocode/json?address=ADDRESS&key="
APIKEY = "AIzaSyD3AuK9RUlJT84ytmkx5MK8LH2EAZVbUVY"

googleGeocodeURL += APIKEY

webcams = {}

jsonfile.readFile infile, (err, obj) ->

    webcams = {}
    
    DELAY = 150

    objarray = obj

    # so hacky but Q wasn't working; got to rate-limit API requests
    offset = 0
    callbackn = 0
    objarray.forEach (o) ->
        setTimeout ->
            geocodeLookup o, (data) ->
                callbackn += 1
                if data
                    webcams[data.title] = data
                if callbackn == objarray.length 
                    console.log "DONE"
                    jsonfile.writeFile outfile, webcams, {spaces: 2}, (err) ->
                        console.error(err)
        , offset
        offset += DELAY 



geocodeLookup = (o, callback) ->
    console.log "starting a lookup"
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
                callback(o)
            catch e 
                console.log "ERROR==="
                console.log u
                console.log e
                console.log body
                callback()

