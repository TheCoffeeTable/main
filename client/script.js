'use strict';
var app = angular.module('CoffeeApp',[]);
app.controller('CoffeeCtrl',function($scope,$http){
	$http.get("get-category.php")
		.then(function(response) {
			$scope.categories = response.data;
	});
	
	$http.get("get-item.php")
		.then(function(response) {
			$scope.item = response.data;
	});
});