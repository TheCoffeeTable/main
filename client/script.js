'use strict';
var app = angular.module('CoffeeApp',[]);
app.controller('CoffeeCtrl',function($scope,$http){
	$http.get("get-data.php")
		.then(function(response) {
			$scope.data = response.data;
	});
});