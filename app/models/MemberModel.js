var mongoose = require('mongoose'),
	Schema = mongoose.Schema,
	ObjectId = Schema.ObjectId;

var WebcamSchema = new Schema({
	id        : ObjectId,
	title     : { type: String, required: true},
	description: { type: String, required: false},
	url      : { type: String, required: true},
	gmt      : { type: Number, required: true}
});

module.exports = mongoose.model('Webcams', WebcamSchema);
