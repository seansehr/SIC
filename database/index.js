var mongoose = require('mongoose');

mongoose.connect('mongodb://localhost/sic');

var PaintSchema = new mongoose.Schema({
  x: Number,
  y: Number,
  z: Number,
  h: Number,
  w: Number,
  time: Number,
});

var Paint = mongoose.model('Paint', PaintSchema);

exports.newPaint = function(req) {
  var newPaint = new Paint(req);
    
  newPaint.save(function (err) {
    if (err) console.log(err);
    console.log('saved');
  });
};

/*exports.findAll = function(data, callback) {
  console.log(data);
  Paint.find({'z': {'$in': data.z}}).sort({timestamp: -1}).execFind(function (err, paints) {
    if (err) console.log(err);
    callback(paints);
  });
};*/

exports.findByInbetween = function(data, callback) {
  Paint
  .find({'time': {'$gte': data.start, '$lte': data.stop}, 'z': {'$in': data.z}})
  .sort({timestamp: -1}).execFind(function (err, paints) {
    if (err) console.log(err);
    callback(paints);
  });
};

/*exports.findByName = function(req, res) {
  Cat.find({name: req.params.name}, function (err, cats) {
    if (err) {
      console.log(err);
    }
    else {
      console.log(cats);
    }
  });
};*/