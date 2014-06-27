define ['lodash', 'c/controllers', 's/search', 's/alert-text', 's/sensorhub', 's/meta'], (_, controllers) ->
	'use strict'

	controllers.controller 'alerts', ['$scope', 'search', 'alerttext', 'sensorhub', 'meta', 'dateFilter', ($scope, search, alerttext, sensorhub, meta, dateFilter) ->
		$scope.meta = meta

		searchParams =
			start	: '30 days ago'

		search.gatewayEvents searchParams, (data) ->
			$scope.gatewayEventsGrouped = _.groupBy data, (item) ->
				dateFilter item.message.timestamp, 'yyyy-MM-dd|MMMM d, yyyy'
			$scope.gatewayEventsDates = Object.keys($scope.gatewayEventsGrouped).sort().reverse()

		sensorhub.getAll {}, (sensorHubs) ->
			$scope.sensorHubs = sensorHubs
			roomNamesBySensorHubMacAddress = {}
			sensorHubs.forEach (sensorHub) ->
				name = meta.roomTypes[sensorHub.roomType] || meta.sensorHubTypes[String(sensorHub.sensorHubType)]
				@[sensorHub._id] = name
			, roomNamesBySensorHubMacAddress

			$scope.roomNamesBySensorHubMacAddress = roomNamesBySensorHubMacAddress


		search.sensorHubEvents searchParams, (data) ->
			$scope.sensorHubEventsGrouped = _.groupBy data, (item) ->
				dateFilter item.message.timestamp, 'yyyy-MM-dd|MMMM d, yyyy'
			$scope.sensorHubEventsDates = Object.keys($scope.sensorHubEventsGrouped).sort().reverse()

		$scope.alerttext = alerttext

  ]