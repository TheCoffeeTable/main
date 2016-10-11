'use strict';
var app = angular.module('CoffeeApp',['ngMaterial','ngRateIt','angular-toast']);
app.controller('CoffeeCtrl',function($scope,$http, $timeout, $mdSidenav, $log,$mdDialog,$mdToast,toast){
    $scope.title = "The Coffee Table";
    $scope.toggleLeft = buildDelayedToggler('left');
    $scope.toggleRight = buildToggler('right');
    $scope.isOpenRight = function(){
      return $mdSidenav('right').isOpen();
    }
    function debounce(func, wait, context) {
      var timer;

      return function debounced() {
        var context = $scope,
            args = Array.prototype.slice.call(arguments);
        $timeout.cancel(timer);
        timer = $timeout(function() {
          timer = undefined;
          func.apply(context, args);
        }, wait || 10);
      };
    }

     function buildDelayedToggler(navID) {
      return debounce(function() {
        // Component lookup should always be available since we are not using `ng-if`
        $mdSidenav(navID)
          .toggle()
          .then(function () {
            $log.debug("toggle " + navID + " is done");
          });
      }, 200);
    }

               
    
    function buildToggler(navID) {
      return function() {
        // Component lookup should always be available since we are not using `ng-if`
        $mdSidenav(navID)
          .toggle()
          .then(function () {
            $log.debug("toggle " + navID + " is done");
          });
      }
    }


    $scope.notify = function(e){

            return toast.show(e || 'Alert')

        }


    $scope.filterQuery = function(e){
      $scope.query = e;
      $scope.close();
    }


    $scope.showSurvey = function(event) {
      $scope.close();
        $mdDialog.show({
          clickOutsideToClose: true,
          scope: $scope,        
          preserveScope: true,           
          templateUrl: 'survey.tmpl.html',
          controller: function DialogController($scope, $mdDialog) {
              $scope.closeDialog = function() {
                $scope.rateSurvey($scope.xForm.answer)
                $mdDialog.hide();
              }

              $http.get("get-survey.php")
                .then(function(response) {
                  $scope.surveyList = response.data;
                  console.log($scope.surveyList)
              });
              

              $scope.rateSurvey = function(x,y){
                $http.post('post-survey.php', {itemno:x,rate:y}) 
                  .success(function(data){
                  window.alert("Great! Thank you for rating me!");
                  //window.location.reload();
                });
              }

          }
        });
    };

  $http.get("get-ip.php")
		.then(function(response) {
			$scope.tableNo = response.data;
	});
  
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
	
  $scope.isOrderEmpty = function(){
       return $scope.order.length > 0 ? false : true
  }

  $scope.openCart = function(event) {
      $mdDialog.show({
        clickOutsideToClose: true,
        scope: $scope,        
        preserveScope: true,           
        template: "<md-dialog>" +
                    "  <md-dialog-content>" +
                    "     <h2>Your Cart:</h2>" +
                    "<table>"+
                        "<tr ng-repeat='x in order'>"+
                          "<td>{{x.name}}&nbsp;&nbsp;</td>"+
                          "<td>&times; {{x.qty}}&nbsp;&nbsp;</td>"+
                          "<td>{{x.price | currency : '&#8369; '}}&nbsp;&nbsp;</td>"+
                          "<td><md-icon ng-click='removeItem($index)'><i class='material-icons'>&#xe5cd;</i></md-icon></td>"+
                          "<hr class='text-warning'>" +
				"<tr class='text-warning text-align-left'>" +
					"<td colspan='2'><right>A Total of :</right></td>" +
					"<td><strong>{{total| currency : '&#8369; '}}</strong></td>" +
                        "</tr>"+
                    "</table>"+
                    "<hr>" +
			"<md-button class='md-warn' ng-click='orderNow()'>ORDER NOW!</md-button>" +
                    "  </md-dialog-content>" +
                    "</md-dialog>",
        controller: function DialogController($scope, $mdDialog) {
            $scope.closeDialog = function() {
              $mdDialog.hide();
            }
        }
      });
  };

	$scope.order = [];
	$scope.addItem = function(w,x,y,z,t){
		$scope.order.push({itemno:w,name:x,qty:y,price:z,tblno:t});
		//$scope.notify("<strong>"+x+"</strong> has been added to cart!");
		$scope.total = $scope.total + z;
    $mdToast.show($mdToast.simple().textContent(x+" has been added to cart!"));
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
      $mdDialog.hide();
		});
	};

	$scope.rateItem = function(x,y){
		$http.post('rate.php', {itemno:x,rate:y}) 
			.success(function(data){
			window.alert("Great! Thank you for rating me!");
			//window.location.reload();
		});
	}

  



	$scope.close = function () {
      // Component lookup should always be available since we are not using `ng-if`
      $mdSidenav('left').close()
        .then(function () {
          $log.debug("close LEFT is done");
        });

    };


});
