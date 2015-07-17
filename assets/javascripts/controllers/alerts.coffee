define ['lodash', 'c/controllers', 's/search', 's/alert-text', 's/sensorhub', 's/meta'], (_, controllers) ->
	'use strict'

	controllers.controller 'alerts', ['$rootScope', '$routeParams', '$scope', 'search', 'alerttext', 'sensorhub', 'meta', 'dateFilter', ($rootScope, $routeParams, $scope, search, alerttext, sensorhub, meta, dateFilter) ->
		$scope.meta = meta

		$scope.networkHubSearchParams =
			start								: "'30 days ago'"
			macAddress					: $rootScope.currentUser.gateways[0]._id

		$scope.searchParams =
			start								: "'24 hours ago'"
			macAddress					: $rootScope.currentUser.gateways[0]._id

		if $routeParams.sensorHubMacAddress
			$scope.searchParams.sensorHubMacAddress	= $routeParams.sensorHubMacAddress


		$scope.$watch 'networkHubSearchParams.start', ( newValue ) ->
			search.gatewayEvents $scope.networkHubSearchParams, (data) ->
				withoutResetEvents = _.reject data, gatewayEventCode:6
				$scope.gatewayEventsGrouped = _.groupBy withoutResetEvents, (item) ->
					dateFilter item.timestamp, 'yyyy-MM-dd|MMMM d, yyyy'
				$scope.gatewayEventsDates = Object.keys($scope.gatewayEventsGrouped).sort().reverse()


		$scope.filterOptions = []

		sensorhub.getAll {}, (sensorHubs) ->
			$scope.sensorHubs = sensorHubs
			roomNamesBySensorHubMacAddress = {}
			sensorHubs.forEach (sensorHub) ->
				name = meta.roomTypes[sensorHub.roomType] || meta.sensorHubTypes[String(sensorHub.sensorHubType)]
				@[sensorHub._id] = name
				$scope.filterOptions.push { value:sensorHub._id, title:name }
			, roomNamesBySensorHubMacAddress

			$scope.roomNamesBySensorHubMacAddress = roomNamesBySensorHubMacAddress


		$scope.$watchCollection 'searchParams', ( newValue ) ->

			query = angular.extend
				msgType	: 4
			, newValue

			search.sensorHubEvents query, ( data ) ->
				$scope.sensorHubEventsGrouped = _.groupBy data, (item) ->
					dateFilter item.timestamp, 'yyyy-MM-dd|MMMM d, yyyy'
				$scope.sensorHubEventsDates = Object.keys($scope.sensorHubEventsGrouped).sort().reverse()

		$scope.alerttext = alerttext

  ]