var serverURI = "https://investment-hero.herokuapp.com";
var getOrders = serverURI + "/getOrders";

var starterDB = {
       "-KWOSE9hzzK4XKkVZKY0":{
          "current_price":"50",
          "img":"http://investment-hero.herokuapp.com/img/MSFT.jpg",
          "purchase_price":"55",
          "quantity":"123",
          "stop_loss":"46",
          "stop_plan":"did",
          "symbol":"MSFT",
          "take_profit":"54",
          "take_profit_plan":"CNBC"
       },
       "-KWOULtlkkGSGt-vRTR1":{
          "current_price":"20",
          "img":"http://investment-hero.herokuapp.com/img/AAPL.jpg",
          "purchase_price":"107.79",
          "quantity":"123",
          "stop_loss":"18.4",
          "stop_plan":"fjfjd",
          "symbol":"AAPL",
          "take_profit":"21.6",
          "take_profit_plan":"CNBC"
       },
       "-KWPAS3YBCnkuCDqQ71F":{
          "current_price":"40",
          "img":"http://investment-hero.herokuapp.com/img/IBM.jpg",
          "purchase_price":"160.22",
          "quantity":"123",
          "stop_loss":"36.8",
          "stop_plan":"fhfjd",
          "symbol":"IBM",
          "take_profit":"43.2",
          "take_profit_plan":"cjcjhc"
       }
    };

angular.module('dangerZone')
        .config(function($mdThemingProvider) {
          $mdThemingProvider.definePalette('hero', {
            '50': '61bfad',
            '100': '61bfad',
            '200': '61bfad',
            '300': '61bfad',
            '400': '61bfad',
            '500': '61bfad',
            '600': '61bfad',
            '700': '61bfad',
            '800': '61bfad',
            '900': '61bfad',
            'A100': '61bfad',
            'A200': '61bfad',
            'A400': '61bfad',
            'A700': '61bfad',
            'contrastDefaultColor': 'light',    // whether, by default, text (contrast)
                                                // on this palette should be dark or light

            'contrastDarkColors': ['50', '100', //hues which contrast should be 'dark' by default
             '200', '300', '400', 'A100'],
            'contrastLightColors': undefined    // could also specify this if default was 'dark'
          });
          $mdThemingProvider.theme('default')
            .primaryPalette('hero')
            .accentPalette('hero');
        })
        
        .config(['$stateProvider', '$urlRouterProvider', function($stateProvider, $urlRouterProvider) {

          $stateProvider          
          .state('index', {
            url: '/index',
            templateUrl: 'js/index.html',
            controller: 'indexCtrl'
          })
          
          .state('updatePrices', {
            url: '/updatePrices',
            templateUrl: 'js/updatePrices.html',
            controller: 'updatePricesCtrl'
          })

          $urlRouterProvider.otherwise('/index');
        }])

        .run(['$rootScope', '$state', function($rootScope, $state) {
            $rootScope.$on('$stateChangeStart', function(evt, to, params) {              
              if (to.redirectTo) {
                evt.preventDefault();
                $state.go(to.redirectTo, params, {location: 'replace'})
              }
            });
        }])
        
        .controller("dangerZoneCtrl", function($rootScope, $scope, $mdSidenav, $mdToast, $state, $http) {
            $scope.$root.progress = false;
        })
        
        .controller("indexCtrl", function($rootScope, $scope, $mdSidenav, $mdToast, $state, $http) {
            
        })
        
        .controller("updatePricesCtrl", function($rootScope, $scope, $mdSidenav, $mdToast, $state, $stateParams, $http, $mdDialog, $firebaseObject, $firebaseArray, $interval) {
            var interval;
            
            $scope.$root.progress = true;
            $scope.simulation = false;
            
            var ref = firebase.database().ref().child("orders");
            var syncObject = $firebaseObject(ref);
                
            syncObject.$bindTo($scope, "orders").then(function(unbind) {
                $scope.$root.progress = false;
                $scope.loaded = true;
            });
            
            $scope.numOfKeys = function() {
                var counter = 0;
                for (var key in syncObject) {
                    if (key.indexOf('-') == 0) {
                        counter = counter + 1;
                    }
                }
                
                return counter;
            }
    
            $scope.startUpdating = function() {
                interval = $interval($scope.updateTime, 1000);
                $scope.simulation = true;
            }
            
            $scope.stopUpdating = function() {
                $scope.simulation = false;
                $interval.cancel(interval);
            }
              
              var last = {
                  bottom: true,
                  top: false,
                  left: false,
                  right: true
              };
              
              $scope.toastPosition = angular.extend({},last);
              $scope.getToastPosition = function() {
                sanitizePosition();

                return Object.keys($scope.toastPosition)
                  .filter(function(pos) { return $scope.toastPosition[pos]; })
                  .join(' ');
              };

              function sanitizePosition() {
                var current = $scope.toastPosition;
                last = angular.extend({},current);
              }

              $scope.showSimpleToast = function(message) {
                var pinTo = $scope.getToastPosition();

                $mdToast.show(
                  $mdToast.simple()
                    .textContent(message)
                    .position(pinTo)
                    .hideDelay(3000)
                );
              };
            
            $scope.updateTime = function() {
                for (var key in syncObject) {
                    if (key.indexOf('-') == 0) {
                        var number = $scope.orders[key].current_price;
                        var max = number * 1.03;
                        var min = number * 0.97;
                        
                        var newPrice = Math.floor(Math.random() * (max - min + 1) + min);
                        
                        $scope.orders[key].current_price = "" + newPrice;
                        
                        console.log(newPrice + " " + $scope.orders[key].take_profit + " " + $scope.orders[key].stop_loss)
                        
                        if (newPrice >= parseFloat($scope.orders[key].take_profit)) {
                            var tempMsg = $scope.orders[key].symbol + " just hit the Take Profit mark!";
                            
                            $scope.showSimpleToast(tempMsg);
                            $scope.sendMessage(tempMsg, "profit", $scope.orders[key].take_profit_plan);
                            
                            $scope.remove(key);
                        }
                        
                        if (newPrice <= parseFloat($scope.orders[key].stop_loss)) {
                            var tempMsg = $scope.orders[key].symbol + " just hit the Stop Loss mark!";
                            
                            $scope.showSimpleToast($scope.orders[key].symbol + " just hit the Stop Loss mark!");
                            $scope.sendMessage(tempMsg, "loss", $scope.orders[key].stop_loss_plan);
                            
                            $scope.remove(key);
                        }
                    }
                }
            }
            
            $scope.sendMessage = function(messageContent, messageType, messagePlan) {
                var ref = firebase.database().ref().child("conversation");
                $scope.conversation = $firebaseArray(ref);

                $scope.conversation.$add({
                    senderId: "1234",
                    senderName: "Investment Hero",
                    plan: messagePlan,
                    type: messageType,
                    text: messageContent + " According to your plan, " + messagePlan
                });
            }
            
            $scope.populate = function() {
                var ref = firebase.database().ref().child("orders");
                $scope.orders = $firebaseArray(ref);
                
                for (var i = 0; i < Object.keys(starterDB).length; i++) {
                    $scope.orders.$add(starterDB[Object.keys(starterDB)[i]]);
                }
            }
            
            $scope.remove = function(objKey) {
                for (var key in syncObject) {
                    if (key == objKey) {
                        delete $scope.orders[objKey];
                        console.log("DELETED");
                    }
                }
            }
            
//            $scope.changeCurrentPrice = function(item) {                                
//                var id = Object.keys(syncObject).filter(function(key) {return syncObject[key] === item})[0];
//                
//                $mdDialog.show({
//                  controller: ['$rootScope', '$scope', '$mdDialog', '$mdToast', function ($rootScope, $scope, $mdDialog, $mdToast) {
//                      $scope.item = item;
//                      
//                      $scope.closeDialog = function() {
//                          $mdDialog.hide();
//                      };
//
//                      var last = {
//                          bottom: true,
//                          top: false,
//                          left: false,
//                          right: true
//                      };
//                      
//                      $scope.updatePrice = function() {
//                          console.log($scope.newPrice);
//                          console.log(id);
//                          
//                          $http.get('https://investment-hero.herokuapp.com/changeCurrentPrice?id=' + id + '&newPrice=' + $scope.newPrice).
//                                  success(function(data, status, headers, config) {
//                                    $scope.closeDialog();
//                                    $scope.showSimpleToast("Price Updated");
//                                  })
//                                  .error(function(data, status, headers, config) {
//                                    $scope.showSimpleToast("Error Updating Price!");
//                          });
//                      };
//
//                      $scope.toastPosition = angular.extend({},last);
//                      $scope.getToastPosition = function() {
//                        sanitizePosition();
//
//                        return Object.keys($scope.toastPosition)
//                          .filter(function(pos) { return $scope.toastPosition[pos]; })
//                          .join(' ');
//                      };
//
//                      function sanitizePosition() {
//                        var current = $scope.toastPosition;
//                        last = angular.extend({},current);
//                      }
//
//                      $scope.showSimpleToast = function(message) {
//                        var pinTo = $scope.getToastPosition();
//
//                        $mdToast.show(
//                          $mdToast.simple()
//                            .textContent(message)
//                            .position(pinTo)
//                            .hideDelay(3000)
//                        );
//                      };
//                  }],
//                  templateUrl: 'js/partials/changeCurrentPrice.html',
//                  parent: angular.element(document.body),
//                  clickOutsideToClose: true,
//                  fullscreen: false,
//                  openFrom: '#brand',
//                  closeTo: '#brand'
//                });
//            }
        });