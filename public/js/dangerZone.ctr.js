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
        
        .controller("resultsCtrl", function($rootScope, $scope, $mdSidenav, $mdToast, $state, $stateParams, $http, $mdDialog) {
            
        });

//var appearElements = document.querySelectorAll('.appear');
//var appearElementsArray = Array.prototype.slice.call(appearElements, 0);
//
//var timeoutDelay = 1000;
//appearElementsArray.forEach(function(el) {
//    setTimeout(function(){
//        el.classList.add('appear-after');
//        el.classList.remove('appear');
//    }, timeoutDelay);
//    
//    timeoutDelay = timeoutDelay + 1000;
//});