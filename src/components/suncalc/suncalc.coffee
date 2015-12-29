if Meteor.isClient

    @suncalc = {}
    suncalc.parseLatLong = (webcam) ->
        # so we can just cut-paste from google's lat long results
        if 'latlong' of webcam
            [webcam.lat, webcam.long] = _.map webcam['latlong'].split(","), (d) ->
                coord = parseFloat d.replace(/[^0-9.,NW]/g, "")
                if d.match(/[SW]/) 
                    coord *= -1
                return coord 
        return webcam


    suncalc.updateTime = () ->
        console.log "------------ calling updateTime"

        randomCityName = _.sample(_.keys(webcams))
        randomCity = suncalc.parseLatLong(webcams[randomCityName])

        state = 'sunrise'

        nowDate = new Date()

        Session.set "current_time", nowDate

        times = SunCalc.getTimes(nowDate, randomCity.lat, randomCity.long)

        aTime = $("<div><span class='marker'>&#9679;</span><span class='caption'>-- The " + state + " for " + randomCityName.toTitleCase() + " is: " + moment().to(times[state]) + "</span></div>")
            .addClass("sun-time")
            .data("sun-time", moment().diff(times[state], 'minutes'))
            .css("right", moment().diff(times[state], 'minutes'))
            .prependTo("#times")
        console.log(times);
        
        map.AddMarker(randomCityName.toTitleCase(), randomCity.lat, randomCity.long, moment().diff(times[state], 'minutes'))

    suncalc.updateTime()
    Meteor.setInterval(suncalc.updateTime, updateDelay); 
