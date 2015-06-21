var app = angular.module('buzzbands.promoterControllers', []);

app.controller("PromoterIndexController", function($scope, Promoter) {
		$scope.promoters = Promoter.query();
		console.log($scope.promoters)
});

app.controller('PromoterDetailController', ['$scope', 'Promoter',
	function($scope, Promoter){

	}
]);

app.controller('PromoterCreationController', ['$scope', '$rootScope', 'Promoter',
	function($scope, $rootScope, Promoter){
	}
]);
