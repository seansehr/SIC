
/**
  Twitter Calls
**/

var twitter = require('node-twitter'),
    consumerKey = 'OhajGDlT84v8fb8jLo7IEg',
    consumerSecret = 'zMqGDA4a0tvLmQeSMi5S1GFIPLR5fy7KsWlnPBpAA',
    token = '52487986-LJd9Dk7FlnvaEcSf84xwu2NN5M9z4K06BJ9AiMv9t',
    tokenSecret = 'mSG1RFxGf9LQ2gdGyld5yzHJcqbUUQy1YvfScQajk';

var searchClient = twitter.SearchClient(consumerKey, consumerSecret, token, tokenSecret);

/*exports.searchTwitter = function(req, res) {
  console.log(req);
  searchClient.search(req,
    function (err, data) {
      console.log(err);
      console.log(data);
    }
  );
}*/