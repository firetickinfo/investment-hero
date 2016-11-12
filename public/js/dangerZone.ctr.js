var serverURI = "https://investment-hero.herokuapp.com";
var getOrders = serverURI + "/getOrders";

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
                            
              if (to.url == '/results' && params.statusesObject == null) {
                  $state.go('index', {});
              }
              
              if (to.url == '/index') {
                  variables = [];
                  statuses = [];
              }
            });
        }])
        
        .controller("dangerZoneCtrl", function($rootScope, $scope, $mdSidenav, $mdToast, $state, $http) {
            
        })
        
        .controller("indexCtrl", function($rootScope, $scope, $mdSidenav, $mdToast, $state, $http) {
            
        })
        
        .controller("updatePricesCtrl", function($rootScope, $scope, $mdSidenav, $mdToast, $state, $stateParams, $http, $mdDialog) {
            $http.get(getOrders).
                success(function(data, status, headers, config) {
                    console.log(data);
                    $scope.orders = data.body;
                })
                .error(function(data, status, headers, config) {
                    console.error(data);
                });
            
            $scope.changeCurrentPrice = function(index) {
                console.log($scope.orders[Object.keys($scope.orders)[index]].symbol);
                
                var item = $scope.orders[Object.keys($scope.orders)[index]];
                var id = Object.keys($scope.orders)[index];
                
                $mdDialog.show({
                  controller: ['$rootScope', '$scope', '$mdDialog', '$mdToast', function ($rootScope, $scope, $mdDialog, $mdToast) {
                      $scope.item = item;
                      
                      $scope.closeDialog = function() {
                          $mdDialog.hide();
                      };

                      var last = {
                          bottom: true,
                          top: false,
                          left: false,
                          right: true
                      };
                      
                      $scope.updatePrice = function() {
                          console.log($scope.newPrice);
                          console.log(id);
                          
                          $http.post('https://investment-hero.herokuapp.com/changeCurrentPrice?id=' + id + '&newPrice=' + $scope.newPrice).
                                success(function(data, status, headers, config) {
                                    
                                  })
                                  .error(function(data, status, headers, config) {
                                      // called asynchronously if an error occurs
                                      // or server returns response with an error status.
                          });
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
                  }],
                  templateUrl: 'js/partials/changeCurrentPrice.html',
                  parent: angular.element(document.body),
                  clickOutsideToClose: true,
                  fullscreen: false,
                  openFrom: '#brand',
                  closeTo: '#brand'
                });
            }
        });