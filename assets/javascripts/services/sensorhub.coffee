define ['ng', 's/services', 'ngResource'], (angular, services) ->
	'use strict'

	services.factory 'sensorhub', ['$resource', '$rootScope', ($resource, $rootScope) ->

		defaultParams =
			id										: '@_id'

		$resource '/api/sensor-hubs/:id', defaultParams,
			getAll:
				isArray	: true
				params:
					sensorHubMacAddresses	: $rootScope.currentUser.gateways[0].sensorHubs
			update:
				method: 'PUT'

	]