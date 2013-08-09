
/**
  Twitter Calls
**/

var twitter = require('node-twitter'),
    consumerKey = 'OhajGDlT84v8fb8jLo7IEg',
    consumerSecret = 'zMqGDA4a0tvLmQeSMi5S1GFIPLR5fy7KsWlnPBpAA',
    token = '52487986-LJd9Dk7FlnvaEcSf84xwu2NN5M9z4K06BJ9AiMv9t',
    tokenSecret = 'mSG1RFxGf9LQ2gdGyld5yzHJcqbUUQy1YvfScQajk';

var searchClient = new twitter.SearchClient(consumerKey, consumerSecret, token, tokenSecret);

exports.searchTwitter = function(req, callback) {
  searchClient.search({'q': 'kellytalaske', 'lang': 'en', 'result_type': 'recent' ,'count': 100},
    function (error, data) {
      if(error) console.log('Error: ' + (error.code ? error.code + ' ' + error.message : error.message));
      var tweets = '';
      data.statuses.sort(function(a, b){
        var dateA=new Date(a.created_at), dateB=new Date(b.created_at)
         return dateB-dateA //sort by date ascending
      });
      for(var i in data.statuses) {
        tweets += i + ': ' + data.statuses[i].text + ' @ ' + data.statuses[i].created_at + '<br />';
      }
      callback(tweets);
    }
  );
}