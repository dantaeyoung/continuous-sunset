if Meteor.isClient

    # counter starts at 0
    Session.setDefault "counter", 0
    Template.current_time.helpers
        counter: ->
            Session.get "counter"
        current_time: ->
            Session.get "current_time"

    Template.current_time.events
        "click button": ->
            # increment the counter when button is clicked
            Session.set "counter", Session.get("counter") + 1
            return

    updateTime = () ->
        console.log "------------ calling updateTime"
        randomCityName = _.sample(_.keys(@cities))
        randomCity = @cities[randomCityName]
        console.log randomCityName
        console.log randomCity
        nowDate = new Date()
        times = SunCalc.getTimes(nowDate, randomCity.lat, randomCity.long)
        console.log times
        timesDiff = _.object(_.map(times, (val, key) ->
            return [key, moment().to(val)]
        ))
        $("#times").append("<div>" + timesDiff['sunrise'] + "</div>")
        
        console.log timesDiff


    updateTime()
    Meteor.setInterval(updateTime, 2000); 

if Meteor.isServer
    Meteor.startup ->


# code to run on server at startup
