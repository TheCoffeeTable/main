
var app = angular.module('adminApp',['ngMaterial','ngRoute']);
app.value('customer',{})
app.config(function($routeProvider,$mdThemingProvider) {
        $mdThemingProvider.theme('customTheme') 
                  .primaryPalette('orange')
                  .accentPalette('green')
                  .warnPalette('red');
               

        $routeProvider

            // route for the home page
            .when('/', {
                templateUrl : 'index.html',
                controller  : 'adminApp'
            })

            // route for the monitoring page
            .when('/monitor', {
                templateUrl : 'pages/monitoring.html',
                controller  : 'monitorCtrl'
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
app.controller('transCtrl',function($scope,$http,$mdBottomSheet){
    $scope.openBottomSheet = function() {
        $mdBottomSheet.show({
	      templateUrl: 'template.html',
	      controller: 'GridBottomSheetCtrl',
	      targetEvent: $event
	    }).then(function(clickedItem) {
	      //$scope.alert = clickedItem.name + ' clicked!';
	    });
    };
})

//Controller ng monitoring page
app.controller('monitorCtrl',function(customer,$scope,$http,$mdBottomSheet){
    $http.get("get-table.php")
            .then(function(response) {
                $scope.order = response.data;
        });
    
    $scope.showListBottomSheet = function(e) {
        customer.table = e;
        
        $mdBottomSheet.show({
	      templateUrl: 'pages/bottomsheet.html',
          controller: 'sheetCtrl'
	    }).then(function(clickedItem) {
	      //$scope.alert = clickedItem.name + ' clicked!';
	    });
    };
})

app.controller('sheetCtrl',function(customer,$scope,$http){
    $scope.me = customer.table;
    $http.post('get-order.php', {item:$scope.me}) 
        .success(function(data){
            $scope.order = data;
            console.log($scope.order)
    });
})


//Controller ng User Control page
app.controller('userCtrl',function($scope,$http){
    
})