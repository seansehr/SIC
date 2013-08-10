/*jslint devel: true, browser: true, sloppy: true, nomen: true, maxerr: 50, indent: 2 */

/**
 * Module dependencies.
 */

var io = require('socket.io'),
    connect = require('connect'),
    express = require('express'),
    mongoose = require('mongoose'),
    db = require('./custom_modules/database.js'),
    fs = require('fs'),
    twitter = require('./custom_modules/twitter');


/**
 * Websocket Server
 */
var app = connect().use(connect.static('public')).listen(3000),
    canvas = io.listen(app);

canvas.sockets.on('connection', function (socket) {

  socket.on('paint', function (data) {
    data.time = new Date().getTime();
    
    db.newPaint(data, function (result) {
      canvas.sockets.emit('chat', {message: JSON.stringify(result)});
    });
  });

  socket.on('findByInbetween', function (data) {
    if (data.start !== undefined && data.stop !== undefined) {
      var newData = db.spawn(db.defaults, data);
      db.findByInbetween(newData, function (results) {
        socket.emit('entrance', {message: JSON.stringify(results)});
      });
    }
    else {
      canvas.sockets.emit('chat', {message: 'Start or Stop time is undefined'});
    }

  });

  db.findByInbetween(db.defaults, function (results) {
    for(var i in results) {
      socket.emit('entrance', {message: JSON.stringify(results[i])});
    }
  });
});
console.log('Websocket server running on port 3000');


/**
 * REST API Server
 */
var restAPI = express();

restAPI.get('/paints', function (req, res) {
  db.findByInbetween(db.defaults, function (results) {
    res.json(results);
  });
});
restAPI.get('/canvas/:z', function (req, res) {
  db.defaults.z = [req.params.z];
  db.findByInbetween(db.defaults.z, function (results) {
    res.json(results);
  });
});

/**
 * use twitter path and pass search parameters as url parameters
 * https://dev.twitter.com/docs/api/1.1
 *
 * examples
 * twitter/statuses/mentions_timeline
 * twitter/statuses/mentions_timeline?count=10
 * twitter/search/tweets?q=john%20smith&lang=en&result_type=recent&count=100
 */
restAPI.get('/twitter/*', function (req, res) {
  twitter.twitter(req.route.params[0], req.query, function (results) {
    res.json(results);
  });
});
 
restAPI.listen(3001);
console.log('restAPI server running on port 3001');
