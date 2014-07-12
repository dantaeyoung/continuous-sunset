var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res) {
  res.render('index', { title: 'Express' });
});

router.get('/helloworld', function(req, res) {
  res.render('helloworld', { title: 'Express Hello' });
});

router.get('/webcamlist', function(req, res) {
  res.render('webcamlist', { title: 'List of Webcams' });
});

module.exports = router;
