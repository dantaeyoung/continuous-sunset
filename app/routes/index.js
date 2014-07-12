var express = require('express');
var router = express.Router();

var webcamAPI = require("../controllers/webcam");

/* GET home page. */
exports.index = function(req, res) {
  res.render('index', { title: 'Express' });
};

exports.helloworld = function(req, res) {
  res.render('helloworld', { title: 'Express Hello' });
};

exports.webcamlist = function(req, res) {
	//webcamapi is sent a callback function
	webcamAPI.list(function(err, thisres) {
  		res.render('webcamlist', { title: 'List of Webcams', webcams: thisres });
	});
};

exports.gmt = function(req, res) {
	var reqgmt = req.params.gmt;
	if(reqgmt) {
		console.log(reqgmt);
		webcamAPI.findByGMT(reqgmt, function(err, thisres) {
			console.log(thisres);
			res.render('bygmt', {title: 'Get By GMT ' + reqgmt, webcams: thisres});
		});
	}
};

exports.submit = function(req, res) {
	res.render('submit', { title: 'submit a webcam!'});
};

exports.submit_post = function(req, res) {
	webcamAPI.addWebcam(req, res, function(err, message) {
//		res.send('200', message);
		res.redirect('/');


	});
};

//module.exports = router;
