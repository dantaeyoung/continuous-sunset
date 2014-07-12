var mongoose = require('mongoose'),
	Schema = mongoose.Schema,
	ObjectID = Schema.ObjectID;

var WebcamSchema = new Schema({
	title     : { type: String, required: true},
	description: { type: String, required: false},
	url      : { type: String, required: true},
	gmt      : { type: Number, required: true}
});

module.exports = mongoose.model('Webcam', WebcamSchema);
