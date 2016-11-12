var variables = [];
var variableNames = ["ALT", "Albumin", "A/G Ratio", "Alkaline", "AST", "Bilirubin", "BUN", "BUN/creatinine ratio", "Calcium", "Chloride", "Creatinine", "Fasting glucose", "Phosphorus", "Potassium", "Sodium", "Total cholesterol", "Triglycerides", "HDL", "Carbon Dioxide"];
var statuses = [];

var db = [
            {
              "ALT": {
                "unit": "IU/L",
                "low": 8,
                "high": 37,
                "lowMsg": "Liver Damage",
                "highMsg": "Liver Damage",
                "desc": "This test looks at levels of the liver enzyme ALT. When all’s well with your liver, your score on this test should be within range. Anything higher may indicate liver damage."
              },
              "Albumin": {
                "unit": "g/dL",
                "low": 3.9,
                "high": 5,
                "lowMsg": "Liver or Kidney Problem",
                "highMsg": "Liver or Kidney Problem",
                "desc": "A protein made by the liver, albumin levels can be an indicator of liver or kidney problems."
              },
              "A/G Ratio": {
                "unit": "g/dL",
                "low": "?",
                "high": "?",
                "lowMsg": "?",
                "highMsg": "?",
                "desc": "Healthy ratio: a bit over 1, favoring albumin. There are two types of protein your blood — albumin and globulin. The A/G ratio test compares levels of these proteins with one another."
              },
              "Alkaline": {
                "unit": "IU/L",
                "low": 44,
                "high": 147,
                "lowMsg": "liver or bone-related disease",
                "highMsg": "liver or bone-related disease",
                "desc": "This enzyme is involved in both liver and bone, so elevations may indicate problems with the liver or bone-related disease."
              },
              "AST": {
                "unit": "IU/L",
                "low": 10,
                "high": 34,
                "lowMsg": "Problems may be occurring in one or both Heaart and Liver Tissues",
                "highMsg": "Problems may be occurring in one or both Heaart and Liver Tissues",
                "desc": "This enzyme is found in heart and liver tissue, so elevations suggest problems may be occurring in one or both of those areas."
              },
              "Bilirubin": {
                "unit": "mg/dL",
                "low": 0.1,
                "high": 1.9,
                "lowMsg": "problems in bile ducts, and anemia",
                "highMsg": "problems in bile ducts, and anemia",
                "desc": "This provides information about liver and kidney functions, problems in bile ducts, and anemia."
              },
              "BUN": {
                "unit": "mg/dL",
                "low": 10,
                "high": 20,
                "lowMsg": "severe liver disease, malnutrition or overhydrated",
                "highMsg": "May indicate a problem with kidney function or A number of medications and a diet high in protein can also raise BUN levels",
                "desc": "This is another measure of kidney and liver functions. High values may indicate a problem with kidney function. A number of medications and a diet high in protein can also raise BUN levels."
              },
              "BUN/creatinine ratio": {
                "unit": "mg/dL",
                "low": "10,1",
                "high": "20,1",
                "lowMsg": "reduced kidney function",
                "highMsg": "reduced kidney function",
                "desc": "This test shows if kidneys are eliminating waste properly. High levels of creatinine, a by-product of muscle contractions, are excreted through the kidneys and suggest reduced kidney function."
              },
              "Calcium": {
                "unit": "mg/dL",
                "low": 9,
                "high": 10.5,
                "lowMsg": "Hypocalcemia",
                "highMsg": "kidney problems; overly active thyroid or parathyroid glands; lymphoma; problems with the pancreas; or a deficiency of vitamin D",
                "desc": "Too much calcium in the bloodstream could indicate kidney problems; overly active thyroid or parathyroid glands; certain types of cancer, including lymphoma; problems with the pancreas; or a deficiency of vitamin D."
              },
              "Chloride": {
                "unit": "mEq/L",
                "low": 98,
                "high": 106,
                "lowMsg": "hypochloremia",
                "highMsg": "overly acidic environment in the body, dehydration, multiple myeloma, kidney disorders, or adrenal gland dysfunction",
                "desc": "This mineral is often measured as part of an electrolyte panel. A high-salt diet and/or certain medications are often responsible for elevations in chloride. Excess chloride may indicate an overly acidic environment in the body. It also could be a red flag for dehydration, multiple myeloma, kidney disorders, or adrenal gland dysfunction."
              },
              "Creatinine": {
                "unit": "mg/dL",
                "male": {
                  "low": 0.6,
                  "high": 1.2
                },
                "female": {
                  "low": 0.5,
                  "high": 1.1
                },
                "lowMsg": "problem with kidney function",
                "highMsg": "problem with kidney function",
                "desc": "The kidneys process this waste product, so elevations could indicate a problem with kidney function."
              },
              "Fasting glucose": {
                "unit": "mg/dL",
                "low": 70,
                "high": 99,
                "lowMsg": "hypoglycemia",
                "highMsg": "100 to 125 mg/dL means you have impaired fasting glucose, a type of prediabetes, risk of developing type 2 diabetes, 126 and higher usually means you have diabetes",
                "desc": "Blood sugar levels can be affected by food or beverages you have ingested recently, your current stress levels, medications you may be taking, and the time of day. The fasting blood sugar test is done after at least 6 hours without food or drink other than water."
              },
              "Phosphorus": {
                "unit": "mg/dL",
                "low": 2.4,
                "high": 4.1,
                "lowMsg": "alcoholism, chronic diarrhea, malnutrition, burns or uncontrolled diabetes",
                "highMsg": "problem with kidneys or the parathyroid gland",
                "desc": "Phosphorus plays an important role in bone health and is related to calcium levels. Too much phosphorus could indicate a problem with kidneys or the parathyroid gland. Alcohol abuse, long-term antacid use, excessive intake of diuretics or vitamin D, and malnutrition can also elevate phosphorus levels."
              },
              "Potassium": {
                "unit": "mEq/L",
                "low": 3.7,
                "high": 5.2,
                "lowMsg": "Problem with functioning of nerve and muscles cells, drugs that are often taken for high blood pressure, can cause low levels of potassium",
                "highMsg": "Probem with functioning of nerve and muscles cells",
                "desc": "This mineral is essential for relaying nerve impulses, maintaining proper muscle functions, and regulating heartbeats. Diuretics, drugs that are often taken for high blood pressure, can cause low levels of potassium."
              },
              "Sodium": {
                "unit": "mEq/L",
                "low": 135,
                "high": 145,
                "lowMsg": "dehydration; disorders of the adrenal glands; excessive intake of salt, corticosteroids, or pain-relieving medications; or problems with the liver or kidneys",
                "highMsg": "dehydration; disorders of the adrenal glands; excessive intake of salt, corticosteroids, or pain-relieving medications; or problems with the liver or kidneys",
                "desc": "Another member of the electrolyte family, the mineral sodium helps your body balance water levels and helps with nerve impulses and muscle contractions. Irregularities in sodium levels may indicate dehydration; disorders of the adrenal glands; excessive intake of salt, corticosteroids, or pain-relieving medications; or problems with the liver or kidneys."
              },
              "Total cholesterol": {
                "unit": "mg/dL",
                "low": -200,
                "high": 240,
                "lowMsg": "Healthy",
                "highMsg": "Risk of Heart disease",
                "desc": "This test measures combined levels of both LDL (bad) and HDL (good) cholesterol. The test may be done simply to record an individual’s cholesterol levels or for comparison purposes (e.g., to determine if cholesterol-lowering medications or nutrients are working)."
              },
              "Triglycerides": {
                "unit": "mg/dL",
                "low": 40,
                "high": 160,
                "lowMsg": "heart disease and other health problems",
                "highMsg": "heart disease and other health problems",
                "desc": "These fats are found in the bloodstream and may contribute to heart disease and other health problems."
              },
              "HDL": {
                "unit": "mg/dL",
                "low": 50,
                "high": 60,
                "lowMsg": "risk factors for heart disease",
                "highMsg": "risk factors for heart disease",
                "desc": "Also known as good cholesterol, HDL (high-density lipoprotein) protects against heart disease. Low scores are risk factors for heart disease."
              },
              "Carbon Dioxide": {
                "unit": "mEq/L",
                "low": 23,
                "high": 29,
                "lowMsg": "dehydration, blood transfusions, or overuse of medicines that contain bicarbonate (especially antacids)",
                "highMsg": "dehydration, blood transfusions, or overuse of medicines that contain bicarbonate (especially antacids)",
                "desc": "Carbon dioxide (CO2) is a gaseous waste product from metabolism. The blood carries carbon dioxide to your lungs, where it is exhaled. More than 90% of it in your blood exists in the form of bicarbonate (HCO3). The rest of it is either dissolved carbon dioxide gas (CO2) or carbonic acid (H2CO3). Your kidneys and lungs balance the levels of carbon dioxide, bicarbonate, and carbonic acid in the blood."
              }
            }
        ];

//var test = [];
//var counter = 0;
//for (var key in db[0]) {
//    test[counter] = key;
//    counter++;
//}
//
//console.log(test);

var PROGRESS_STEPS = ["Downloading the Image",
                      "Extracting your results data",
                      "Analyzing the Data"];

angular.module('dangerZone')
        .config(function($mdThemingProvider) {
          $mdThemingProvider.theme('default')
            .primaryPalette('red')
            .accentPalette('indigo');
        })
        
        .config(['$stateProvider', '$urlRouterProvider', function($stateProvider, $urlRouterProvider) {

          $stateProvider          
          .state('index', {
            url: '/index',
            templateUrl: 'components/index.html',
            controller: 'indexCtrl'
          })
          
          .state('results', {
            url: '/results',
            templateUrl: 'components/results.html',
            controller: 'resultsCtrl',
            params: {
                statusesObject: null
            }
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
            $scope.PROGRESS_STEPS = PROGRESS_STEPS;
    
            $scope.changed = function(evt) {
                $scope.files = evt.target.files;
            }
            
            $scope.analyze = function() {
//                console.log($scope.files.length);
                
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

                    if ( current.bottom && last.top ) current.top = false;
                    if ( current.top && last.bottom ) current.bottom = false;
                    if ( current.right && last.left ) current.left = false;
                    if ( current.left && last.right ) current.right = false;

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
                
                if ((typeof $scope.files === 'undefined') != true) {
                    if ($scope.files.length > 0) {
                        $scope.progress = true;
                        $scope.progressIndex = 0;

                        var files = $scope.files;
                        var file = files[0];

                        if (files && file) {
                            var reader = new FileReader();

                            reader.onload = function(readerEvt) {
                                $scope.progressIndex = 1;
                                var binaryString = readerEvt.target.result;

                                var parameter = JSON.stringify({
                                     "requests": [
                                      {
                                       "features": [
                                        {
                                         "type": "TEXT_DETECTION"
                                        }
                                       ],
                                       "image": {
                                         "content": btoa(binaryString)
                                       }
                                      }
                                     ]
                                    });

                                $http.post('https://vision.googleapis.com/v1/images:annotate?key= AIzaSyBMSx7JI7HlEnGLKUJ0goYuJhbJq1kWHYg', parameter).
                                success(function(data, status, headers, config) {
                                    $scope.progressIndex = 2;

                                    // this callback will be called asynchronously
                                    // when the response is available
                                    
                                    if ((typeof data.responses[0].textAnnotations === 'undefined') != true) {
                                        console.log(data.responses[0].textAnnotations[0].description.split('\n'));

                                        $scope.getVariables(data.responses[0].textAnnotations[0].description.split('\n'));
                                    } else {
                                        $scope.progress = false;
                                        
                                        $scope.showSimpleToast('Please Upload a Picture of Your Lab Results!');
                                    }
                                  })
                                    .error(function(data, status, headers, config) {
                                    // called asynchronously if an error occurs
                                    // or server returns response with an error status.
                                  });
                            };

                            reader.readAsBinaryString(file);
                        }
                    } else {
                        $scope.showSimpleToast('Please Choose a file!');
                    }
                } else {                  
                  $scope.showSimpleToast('Please Choose a file!');
                }
            }
            
            $scope.getBase64FromImageUrl = function(evt) {
                    
//                var img = new Image();
//
//                img.setAttribute('crossOrigin', 'anonymous');
//
//                img.onload = function () {
//                    $scope.progressIndex = 1;
//                    
//                    var canvas = document.createElement("canvas");
//                    canvas.width =this.width;
//                    canvas.height =this.height;
//
//                    var ctx = canvas.getContext("2d");
//                    ctx.drawImage(this, 0, 0);
//
//                    var dataURL = canvas.toDataURL("image/jpg");
//                    dataURL = dataURL.replace("data:image/png;base64,", "");

//                    console.log(dataURL);
            }
            
            $scope.getVariables = function(data) {
                for (var i = 0; i < data.length; i++) {
                    for (var k = 0; k < variableNames.length; k++) {
                        var variableToCheckFor = variableNames[k];
                        
                        if (variableNames[k] != "ALT" && variableNames[k] != "AST") {
                            variableToCheckFor = variableNames[k].toLowerCase();
                            
                            if (data[i].toLowerCase().indexOf(variableToCheckFor) != -1) {
                                for (var j = i; j < data.length; j++) {
                                    if (!isNaN(data[j])) {
                                        variables[variableNames[k]] = data[j];

                                        break;
                                    }
                                }
                            }
                        } else {
                            if (data[i].indexOf(variableToCheckFor) != -1) {
                                for (var j = i; j < data.length; j++) {
                                    if (!isNaN(data[j])) {
                                        variables[variableNames[k]] = data[j];

                                        break;
                                    }
                                }
                            }
                        }
                        
                        
                    }
                }
                
                console.log(variables);
                
                $scope.analyzeData();
            }
            
            $scope.analyzeData = function() {
                var counter = 0;
                for (var variable in variables) {
                    if (variable != "Creatinine" &&  variable != "A/G Ratio" && variable != "BUN/creatinine ratio") {
                        console.log(variables[variable]);
                        console.log(variable + " " + db[0][variable].low + " " + db[0][variable].high);
                        
                        if (variables[variable] < db[0][variable].low) {
                            console.error("LOOOOOW");
                            statuses[counter] = {"name": variable, "status": "LOW"};
                        } else if (variables[variable] > db[0][variable].high) {
                            console.error("HIGHHHH");
                            statuses[counter] = {"name": variable, "status": "HIGH"};
                        } else {
                            statuses[counter] = {"name": variable, "status": "OK"};
                        }
                        
                        counter = counter + 1;
                    }
                }
                
                console.log(statuses);
                
                $state.go('results', {statusesObject:statuses});
            }
        })
        
        .controller("resultsCtrl", function($rootScope, $scope, $mdSidenav, $mdToast, $state, $stateParams, $http, $mdDialog) {
            $scope.db = db;
            console.log("statusesObject");
            console.log($stateParams.statusesObject);
            $scope.statusesObj = $stateParams.statusesObject;
            console.log($scope.statusesObj);
            
            $scope.infoDialog = function(name) {                
                $mdDialog.show({
                  controller: ['$scope', function ($scope) {
                      $scope.closeDialog = function() {
                          $mdDialog.hide();
                      };
                      
                      $scope.item = db[0][name];
                      $scope.name = name;
                      $scope.db = db;
                      $scope.variables = variables;
                  }],
                  templateUrl: 'components/infoDialog.html',
                  parent: angular.element(document.body),
                  clickOutsideToClose: true,
                  fullscreen: false
                });
            };
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