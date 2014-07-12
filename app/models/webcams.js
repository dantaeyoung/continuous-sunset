var mongoose = require('mongoose'),
	Schema = mongoose.Schema;

var Webcam = new Schema({
	title     : { type: String, required: true},
	description: { type: String, required: false},
	url      : { type: String, required: true},
	gmt      : { type: Number, required: true}
});

mongoose.model('Webcam', Webcam);
