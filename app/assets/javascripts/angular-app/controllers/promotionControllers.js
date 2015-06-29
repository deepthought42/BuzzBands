var app = angular.module('buzzbands.promotionControllers', []);

app.controller("PromotionIndexController", ['$scope', 'Promotion', function($scope, Promottion) {
		$scope.promotions = Promotion.query();
		console.log($scope.promoters)
});

app.controller('PromotionDetailController', ['$scope', 'Promotion',
	function($scope, Promotion){

	}
]);

app.controller('PromotionCreationController', ['$scope', '$rootScope', 'Promotion',
	function($scope, $rootScope, Promotion){
	}
]);
