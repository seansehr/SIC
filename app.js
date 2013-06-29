
/**
 * Module dependencies.
 */

var io = require('socket.io'),
    connect = require('connect'),
    mongoose = require('mongoose'),
    db = require('./database');

var app = connect().use(connect.static('public')).listen(3000);
var canvas = io.listen(app);

var Find = {
  'z': [1, 2, 3],
  'start': 0,
  'stop': new Date().getTime()
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
    socket.emit('entrance', {message: JSON.stringify(results)});
  });

});