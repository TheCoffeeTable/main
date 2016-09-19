'use strict';
var app = angular.module('CoffeeApp',['ui.bootstrap']);
app.controller('CoffeeCtrl',function($scope,$http){
	$http.get("get-category.php")
		.then(function(response) {
			$scope.categories = response.data;
	});
	
	$http.get("get-item.php")
		.then(function(response) {
			$scope.item = response.data;
	});
	
	$scope.order = [];
	$scope.addItem = function(w,x,y,z){
		$scope.order.push({itemno:x,name:x,qty:y,price:z});
		console.log($scope.order);
	};
	
	$scope.dynamicPopover = {
		templateUrl: 'myPopoverTemplate.html',
		title: 'Your Order List:'
	  };

	$scope.removeItem = function(e){
		$scope.order.splice(e, 1);
	}
});