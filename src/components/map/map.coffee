if Meteor.isClient
	Meteor.startup ->
		GoogleMaps.load()

	Template.map.helpers
		mapOptions: ->
			if GoogleMaps.loaded()
				opt = {
					center: new google.maps.LatLng(40.7127, -74.0059) 
					zoom: 2 
					styles: mapstyles
				}
				console.log opt
				return opt

	@map = {}

	map.minutesToColor = (minutesTo) ->
		interpolator = d3.interpolate("#ffcc00", "#000000")
		cutoffFactor = 5
		m = Math.abs(minutesTo / 1440 * cutoffFactor)
		if m < 0.1
			return "#F39"
		console.log m
		console.log interpolator(m)
		return interpolator(m)

	map.panTo = (lat, long) ->
		if GoogleMaps.loaded()
			GoogleMaps.maps.map.instance.panTo({lat: lat, lng: long})

	map.AddMarker = (name, lat, long, minutesTo) ->
		if GoogleMaps.loaded()
			marker = new google.maps.Marker
				animation: google.maps.Animation.DROP
				position: new google.maps.LatLng(lat, long)
				map: GoogleMaps.maps.map.instance
				title: name
				icon:
					path: google.maps.SymbolPath.CIRCLE
					strokeOpacity: 0.0
					fillColor: map.minutesToColor(minutesTo)
					fillOpacity: 1.0
					scale: 7 
			map.panTo(lat, long)
#            GoogleMaps.maps.map.instance.panTo(marker.getPosition())
