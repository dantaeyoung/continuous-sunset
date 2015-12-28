if Meteor.isClient

    updateTime = () ->
        console.log "------------ calling updateTime"

        randomCityName = _.sample(_.keys(@cities))
        randomCity = @cities[randomCityName]

        state = 'sunrise'

        nowDate = new Date()
        times = SunCalc.getTimes(nowDate, randomCity.lat, randomCity.long)

        aTime = $("<div><span class='marker'>&#9679;</span><span class='caption'>-- The " + state + " for " + randomCityName.toTitleCase() + " is: " + moment().to(times[state]) + "</span></div>")
            .addClass("sun-time")
            .data("sun-time", moment().diff(times[state], 'minutes'))
            .css("right", moment().diff(times[state], 'minutes'))
            .prependTo("#times")
        console.log(times);
        
        map.AddMarker(randomCityName.toTitleCase(), randomCity.lat, randomCity.long, moment().diff(times[state], 'minutes'))

    updateTime()
    Meteor.setInterval(updateTime, 30); 
