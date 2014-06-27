define ['ng', 's/services', 'ngResource'], (angular, services) ->
	'use strict'

	services.factory 'latest', ['$resource', '$rootScope', ($resource, $rootScope) ->

		defaultParams =
			sensorHubMacAddresses: $rootScope.currentUser.gateways[0].sensorHubs

		$resource '/api/latest/sensor-hub-events', defaultParams


	]