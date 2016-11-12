var express = require('express');
var router = express.Router();

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

module.exports = router;