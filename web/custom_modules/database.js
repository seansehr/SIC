var mongoose = require('mongoose');

mongoose.connect('mongodb://localhost/sic');

var PaintSchema = new mongoose.Schema({
  x: Number,
  y: Number,
  z: Number,
  h: Number,
  w: Number,
  color: String,
  time: Number,
});

var Paint = mongoose.model('Paint', PaintSchema);

exports.newPaint = function (req, callback) {
  var newPaint = new Paint(req);
    
  newPaint.save(function (err, data) {
    if (err) {
      console.log(err);
    }
    else {
      callback(data);
      console.log('saved');
    }
  });
};

exports.findByInbetween = function (data, callback) {
  Paint.find({
    'time': {
      '$gte': data.start,
      '$lte': data.stop
    },
    'z': {'$in': data.z}
  })
  .sort({timestamp: -1})
  .execFind(function (err, paints) {
    if (err) console.log(err);
    callback(paints);
  });
};

exports.spawn = function (parent, props) {
  var defs = {}, key;
  for (key in props) {
    if (props.hasOwnProperty(key)) {
      defs[key] = {value: props[key], enumerable: true};
    }
  }
  return Object.create(parent, defs);
};

exports.defaults = {
  'z': [1, 2, 3],
  'start': 0,
  'stop': 9999999999999
};