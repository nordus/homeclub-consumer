define ['ng', 's/services', 'ngResource'], (angular, services) ->
	'use strict'

	services.factory 'search', ['$resource', '$rootScope', ($resource, $rootScope) ->

		defaultParams =
		  limit                 : 10000
		  macAddress            : $rootScope.currentUser.gateways[0]._id
		  sensorHubMacAddresses : $rootScope.currentUser.gateways[0].sensorHubs

		search = $resource '/api/search', defaultParams, {getAll:{isArray:true}}
		
		sensorHubData: (params, success) ->
			params = angular.extend({msgType:5}, params)
			
			results = search.get params, ->
				success results

		gatewayEvents: (params, success) ->
			params = angular.extend({msgType:2}, params)
			
			results = search.getAll params, ->
				success results

		sensorHubEvents: (params, success) ->
			params = angular.extend({msgType:4}, params)

			results = search.getAll params, ->
				success results

	]