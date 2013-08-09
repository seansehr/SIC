
/**
 * Module dependencies.
 */

// Connect to server
var io = require('socket.io-client'),
    server = 'http://localhost:3000',
    socket = io.connect('http://localhost:3000', {reconnect: true}),
    fs = require('fs'),
    watchr = require('watchr'),
    file = './data.txt',
    z = 1,
    h = 200,
    w = 200;

// Add a connect listener
socket.on('connect', function(){
  console.log('connected to ' + server);
  socket.on('disconnect', function(){
    console.log('disconnect');
  });
  watchr.watch({
    paths: [file],
    listeners: {
      change: function (changeType,filePath,fileCurrentStat,filePreviousStat) {
        fs.readFile(file, {'encoding': 'utf8'}, function (err, data) {
          data = JSON.parse(data),
          data.z = z,
          data.h = h,
          data.w = w;
          console.log(data);
          socket.emit('paint', data);
        });
      }
    },
    interval: 500,
  });
});
