var buzzbands = angular.module('ideaBin',
	[ 'ngRoute',
		'templates',
		'ngStorage',
		'ipCookie',
		'ng-token-auth',
		'wu.masonry',
		'ngMessages'])

ideaBin.config(function ($routeProvider, $locationProvider) {

        $routeProvider.when('/', {
					templateUrl: 'idea/index.html',
				.otherwise({redirectTo : '/'});

        $locationProvider.html5Mode({
					enabled: true,
					requireBase: false
				});
    });

ideaBin.run(['$rootScope', '$injector', function($rootScope,$injector) {

 }]);
