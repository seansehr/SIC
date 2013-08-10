/*global Drupal: true, jQuery: true, gigya: true */
/*jslint devel: true, browser: true, sloppy: true, nomen: true, maxerr: 50, indent: 2 */

/**
  Twitter Calls
*/

var twitter = require('twit'),
    consumerKey = 'OhajGDlT84v8fb8jLo7IEg',
    consumerSecret = 'zMqGDA4a0tvLmQeSMi5S1GFIPLR5fy7KsWlnPBpAA',
    token = '52487986-LJd9Dk7FlnvaEcSf84xwu2NN5M9z4K06BJ9AiMv9t',
    tokenSecret = 'mSG1RFxGf9LQ2gdGyld5yzHJcqbUUQy1YvfScQajk';

var T = new twitter({
  consumer_key: consumerKey,
  consumer_secret: consumerSecret,
  access_token: token,
  access_token_secret: tokenSecret
});

/**
 * Format url string for Twitter search
 */
exports.formatString = function (req, func, callback) {
  search = '{"' + req + '"}';
  search = search.replace(/&/g, "\",\"").replace(/=/g,"\":\"");
  search = decodeURI(search);
  search = JSON.parse(search);
  func(search, callback);
};

/**
 * @params
 * a list of twitter parameters as a JSON object
 * refer to twitter's documentation for parameters https://dev.twitter.com/docs/api/1.1/get/search/tweets
 */
exports.searchTwitter = function (req, callback) {
  T.get('search/tweets', req, function (err, reply) {
    if(err) console.log(err);
    callback(reply);
  });
};

/**
 * @params
 * a list of twitter parameters as a JSON object
 * refer to twitter's documentation for parameters https://dev.twitter.com/docs/api/1.1/get/search/tweets
 */
exports.mentionsTimeline = function (req, callback) {
  T.get('statuses/mentions_timeline', req, function (err, reply) {
    if(err) console.log(err);
    callback(reply);
  });
};