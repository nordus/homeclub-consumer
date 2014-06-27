define ['c/controllers', 's/sensorhub', 's/latest', 's/meta'], (controllers) ->
	'use strict'

	controllers.controller 'dashboard', ['$scope', 'sensorhub', 'latest', 'meta', ($scope, sensorhub, latest, meta) ->
		sensorhub.getAll {}, (data) -> $scope.sensorHubs = data

		latest.get {}, (data) -> $scope.latest = data

		$scope.cssClassByRssiThreshold = (rssi) ->
			rssi = Number(rssi)
			switch
			  when rssi < -95 then 'label-danger'
			  when rssi < -80 then 'label-warning'
			  else 'label-success'

		$scope.cssClassByBatteryThreshold = (battery) ->
			battery = Number(battery)
			switch
				when battery > 70 then 'label-success'
				when battery > 49 then 'label-warning'
				else 'label-danger'

		$scope.meta = meta

  ]