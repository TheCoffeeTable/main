'use strict';
var app = angular.module('CoffeeApp',['ui.bootstrap','ngRateIt']);
app.controller('CoffeeCtrl',function($scope,$http){
	$scope.TableNumber=1;
	$scope.total = 0;
	$http.get("get-category.php")
		.then(function(response) {
			$scope.categories = response.data;
	});
	
	$http.get("get-item.php")
		.then(function(response) {
			$scope.item = response.data;
	});
	
	$scope.order = [];
	$scope.addItem = function(w,x,y,z,t){
		$scope.order.push({itemno:w,name:x,qty:y,price:z,tblno:t});
		
		$scope.total = $scope.total + z;
	};
	
	$scope.dynamicPopover = {
		templateUrl: 'myPopoverTemplate.html',
		title: 'Your Order List:'
	  };

	$scope.removeItem = function(e){
		console.log($scope.order[e].price)
		$scope.total = $scope.total - $scope.order[e].price;
		$scope.order.splice(e, 1);
	};
	
	$scope.orderNow = function(){
		$http.post('i-order.php', $scope.order) 
			.success(function(data){
			window.alert("Thank you for Ordering!Please wait for the server to respond for your order.");
			$scope.order = [];
			$scope.total = 0;
		});
	};
	
});