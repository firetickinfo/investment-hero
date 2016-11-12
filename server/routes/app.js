var express = require('express');
var router = express.Router();
var jwt = require('jsonwebtoken');

var request = require('request');

var to_json = require('xmljson').to_json;

// Import Admin SDK
var admin = require("firebase-admin");

// Get a database reference to our blog
var serviceAccount = require("../serviceAccountKey.json");
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://investment-hero.firebaseio.com"
});

var db = admin.database();
var ref = db.ref("test");

router.get('/', function (req, res, next) {
    var usersRef = ref.child("users");
    usersRef.set({
      alanisawesome: {
        date_of_birth: "June 23, 1912",
        full_name: "Alan Turing"
      },
      gracehop: {
        date_of_birth: "December 9, 1906",
        full_name: "Grace Hopper"
      }
    });

    res.render('index');
});

router.get('/GetEndOfDayData/:symbol', function (req, res, next) {
    request('http://ws.nasdaqdod.com/v1/NASDAQAnalytics.asmx/GetEndOfDayData?_Token=BC2B181CF93B441D8C6342120EB0C971&Symbols=' + req.params.symbol + '&StartDate=11/10/2016&EndDate=11/10/2016&MarketCenters=', function (error, response, body) {
      if (!error && response.statusCode == 200) {
        to_json(body, function (error, data) {
            var fail = false;
            if (data.ArrayOfEndOfDayPriceCollection.EndOfDayPriceCollection.Prices.EndOfDayPrice.Message) {
                fail = data.ArrayOfEndOfDayPriceCollection.EndOfDayPriceCollection.Prices.EndOfDayPrice.Message.toString().includes("No Trades found for");
            }
            res.status(200).json({
                message: fail ? "Failed" : "Success",
                body: data.ArrayOfEndOfDayPriceCollection.EndOfDayPriceCollection
            });
        });
      }
    });
});

module.exports = router;