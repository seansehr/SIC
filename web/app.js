
/**
 * Module dependencies.
 */

var io = require('socket.io'),
    connect = require('connect'),
    express = require('express'),
    mongoose = require('mongoose'),
    db = require('./database'),
    fs = require('fs'),
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
  console.log('test');

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
restAPI.get('/twitter/:search', function(req, res) {
  search = '{"q=' + req.params.search + '"}';
  search = search.replace(/&/g, "\",\"").replace(/=/g,"\":\"");
  search = decodeURI(search);
  console.log(search);
  search = JSON.parse(search);
  console.log(search);
  //twitter.searchTwitter(term, function(results) {
    //res.send(results);
  //});
});

 
restAPI.listen(3001);
console.log('Listening on port 3001...');
