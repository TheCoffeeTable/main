'use strict';
var app = angular.module('CoffeeApp',[]);
app.controller('CoffeeCtrl',function($scope,$http){
	$http.get("get-category.php")
		.then(function(response) {
			$scope.category = response.data;
	});
	
	$http.get("get-item.php")
		.then(function(response) {
			$scope.data = response.data;
	});
});