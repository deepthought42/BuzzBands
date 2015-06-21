var services = angular.module('buzzbands.promoterServices', ['ngResource']);

services.factory('Promoter', function ($resource) {
    return $resource('/promoters/:id.json', {id: '@id'}, {
        query: { method: 'GET', isArray: true },
        create: { method: 'POST' },
				show: { method: 'GET', isArray: false},
        update: { method: 'PUT'},
        delete: { method: 'DELETE' }
    });
});
