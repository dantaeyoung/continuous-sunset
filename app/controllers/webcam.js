var Webcam = require("../models/webcam");
// now we can do Webcam.find(), etc
//
//
// so the list function for this webcam controller executes find function of the webcam module.
// this may be obvious but writing it out as a reminder.
// finding is handled by the module and is thus db-agnostic
//
exports.list = function(callback) {
	// if error, callback("ERROR");
	Webcam.find(function (err, threads) {
		callback(null, threads);
	});
}

exports.findByGMT = function(thisgmt, callback) {
	Webcam.find({gmt: thisgmt}, function (err, thread) {
		// okay, so we found one, callback is the thread, so now use the thread obj id to actualy find the entire post. 
		var posts = Webcam.find({thread: thread._id}, function (err, posts) {
			callback(null, thread );
		});
	});
}

exports.addWebcam = function(req, res, callback) {

	console.log("submit post tiggled");
	console.log(req.body.title);
	console.log(req);
	var newcam = new Webcam({
		title: req.body.title,
		description: req.body.description,
		url: req.body.url,
		gmt: req.body.gmt
	});
	console.log("newcam = ");
	console.log(newcam);
	newcam.save(function(err) {
		callback(null, "success");
	});


}
