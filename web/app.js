
/**
 * Module dependencies.
 */

var io = require('socket.io'),
    connect = require('connect'),
    express = require('express'),
    mongoose = require('mongoose'),
    db = require('./database'),
    twitter = require('./twitter');

var app = connect().use(connect.static('public')).listen(3000);
var canvas = io.listen(app);

var Find = {
  'z': [1, 2, 3],
  'start': 0,
  'stop': 9999999999999
};

Object.spawn = function (parent, props) {
  var defs = {}, key;
  for (key in props) {
    if (props.hasOwnProperty(key)) {
      defs[key] = {value: props[key], enumerable: true};
    }
  }
  return Object.create(parent, defs);
}

canvas.sockets.on('connection', function (socket) {

  socket.on('paint', function  (data) {
    data.time = new Date().getTime();
    
    db.newPaint(data);
    canvas.sockets.emit('chat', {message: JSON.stringify(data)});

  });

  socket.on('findByInbetween', function (data) {
    if (data.start != undefined && data.stop != undefined) {
      var newData = Object.spawn(Find, data);
      db.findByInbetween(newData, function(results) {
        socket.emit('entrance', {message: JSON.stringify(results)});
      }); 
    }
    else {
      canvas.sockets.emit('chat', {message: 'Start or Stop time is undefined'});  
    }

  });

  db.findByInbetween(Find, function(results) {
    for(var i in results) {
      socket.emit('entrance', {message: JSON.stringify(results[i])});
    }
  });

});

var restAPI = express();

restAPI.get('/paints', function(req, res) {
  db.findByInbetween(Find, function(results) {
    res.send(results);
  });
});
restAPI.get('/canvas/:z', function(req, res) {
  Find.z = [req.params.z];
  db.findByInbetween(Find, function(results) {
    res.send(results);
  });
});
restAPI.get('/twitter/:term', function(req, res) {
  term = [req.params.term];
  twitter.searchTwitter(term);
});

 
restAPI.listen(3001);
console.log('Listening on port 3001...');