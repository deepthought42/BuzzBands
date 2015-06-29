var services = angular.module('buzzbands.promottionServices', ['ngResource']);

services.factory('Promotion', function ($resource) {
    return $resource('/promotions/:id.json', {id: '@id'}, {
				show: { method: 'GET', isArray: false},
    });
});
