
var app = angular.module('adminApp',['ngMaterial','ngRoute']);
app.config(function($routeProvider) {
        $routeProvider

            // route for the home page
            .when('/', {
                templateUrl : 'index.html',
                controller  : 'adminApp'
            })

            // route for the about page
            .when('/transaction', {
                templateUrl : 'pages/transaction.html',
                controller  : 'transCtrl'
            })

            // route for the contact page
            .when('/usercontrol', {
                templateUrl : 'pages/user.html',
                controller  : 'userCtrl'
            });
    });

app.controller('adminCtrl',function($scope,$http, $timeout, $mdSidenav, $log,$mdDialog,$mdToast){
    $scope.openLeftMenu = function() {
        $mdSidenav('left').toggle();
    };

    $scope.close = function () {
      
      $mdSidenav('left').close()
        .then(function () {
         
        });

    };
})

// Controller ng transactions page
app.controller('transCtrl',function($scope,$http){

})


//Controller ng User Control page
app.controller('userCtrl',function($scope,$http){
    
})