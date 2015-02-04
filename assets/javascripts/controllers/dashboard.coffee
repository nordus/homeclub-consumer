define ['c/controllers', 's/sensorhub', 's/latest', 's/meta'], (controllers) ->
	'use strict'

	controllers.controller 'dashboard', ['$scope', 'sensorhub', 'latest', 'meta', ($scope, sensorhub, latest, meta) ->
		sensorhub.getAll {}, (data) -> $scope.sensorHubs = data

		latest.get {}, (data) -> $scope.latest = data

		$scope.cssClassByRssiThreshold = (rssi) ->
      if rssi is undefined
        return 'label-default'
      else
        rssiNum = Number(rssi)
        switch
          when rssiNum < -95 then 'label-danger'
          when rssiNum < -80 then 'label-warning'
          else 'label-success'

		$scope.cssClassByBatteryThreshold = (battery) ->
      if battery is undefined
        return 'label-default'
      else
        batteryNum = Number(battery)
        switch
          when batteryNum > 70 then 'label-success'
          when batteryNum > 49 then 'label-warning'
          else 'label-danger'

		$scope.meta = meta

  ]