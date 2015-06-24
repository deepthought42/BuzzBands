var buzzbands = angular.module('buzzbands',
	[ 'ngRoute',
		'ngResource',
		'templates',
		'ui.bootstrap',
		'ipCookie',
		'ng-token-auth',
		'ngStorage',
		'ngMessages',
		'buzzbands.UserControllers',
		'buzzbands.promoterControllers',
		'buzzbands.promoterServices'
		]);

buzzbands.config(function ($routeProvider, $locationProvider) {

      $routeProvider.when("/", {
				templateUrl: "user/signup.html"
			})
			.when("/promoterIdx", {
				templateUrl: "promoter/index.html"
			});
      $locationProvider.html5Mode(true);
  });

buzzbands.run(['$rootScope', '$injector', function($rootScope,$injector) {
	console.log("BUZZ BANDS STARTED!");
 }]);
