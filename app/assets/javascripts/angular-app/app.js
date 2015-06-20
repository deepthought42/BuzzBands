var buzzbands = angular.module('buzzbands',
	[ 'ngRoute',
		'buzzbands.promoControllers',
		'buzzbands.promoterControllers'])

buzzbands.config(function ($routeProvider, $locationProvider) {

      $routeProvider.when('/home', {
				templateUrl: 'promoter/index.html',
			});

      $locationProvider.html5Mode({
				enabled: true,
				requireBase: false
			});
  });

buzzbands.run(['$rootScope', '$injector', function($rootScope,$injector) {

 }]);
