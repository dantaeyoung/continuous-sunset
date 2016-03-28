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

	suncalc.allTimes = (state=CONSTANTS.state) ->
		nowDate = new Date()
		return _.mapValues webcams, (city, cityname) ->
			times = SunCalc.getTimes(nowDate, city.lat, city.long)
			return moment().diff(times[state], 'minutes')

	suncalc.soonState = (state=CONSTANTS.state, threshold=100) ->
		alltimes = suncalc.allTimes(state)
		soontimes = _.pick alltimes, (v, k) ->
			if v < 0
				return false
			if v < threshold 
				return true
			return false
		return _.mapValues soontimes, (time, city) ->
			thisCity = webcams[city]
			thisCity["time_to_" + state] = time 
			return thisCity

	suncalc.updateTime = () ->
		console.log "------------ calling updateTime"

		randomCityName = _.sample(_.keys(webcams))
		console.log webcams[randomCityName]
		randomCity = suncalc.parseLatLong(webcams[randomCityName])

		nowDate = new Date()

		Session.set "current_time", nowDate

		times = SunCalc.getTimes(nowDate, randomCity.lat, randomCity.long)

		selector = ".webcam_image.camid_" + webcams[randomCityName]['camid']

		if ($(selector).length) 
			$(selector).insertBefore('div.webcam_image:first')
			map.panTo(randomCity.lat, randomCity.long)
		else
			aImg = $("<div><img src='" + webcams[randomCityName]['img_url'] + "' /></div>")
				.addClass("webcam_image")
				.addClass("camid_" + webcams[randomCityName]['camid'])
				.prependTo("#webcam_images")

			###
			aTime = $("<div><span class='marker'>&#9679;</span><span class='caption'>-- The " + CONSTANTS.state + " for " + randomCityName.toTitleCase() + " is: " + moment().to(times[CONSTANTS.state]) + "</span><img class='webcam_img' src='" + webcams[randomCityName]['img_url'] + "' /></div>")
			.addClass("sun-time")
			.data("sun-time", moment().diff(times[CONSTANTS.state], 'minutes'))
			.css("right", moment().diff(times[CONSTANTS.state], 'minutes'))
			.prependTo("#times")
			console.log(times);
			###
			map.AddMarker(randomCityName.toTitleCase(), randomCity.lat, randomCity.long, moment().diff(times[CONSTANTS.state], 'minutes'))

	suncalc.updateTime()
	Meteor.setInterval(suncalc.updateTime, CONSTANTS.updateDelay); 
