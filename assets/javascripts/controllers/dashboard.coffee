define ['c/controllers', 's/alert-text', 's/sensorhub', 's/latest', 's/meta', 's/search'], (controllers) ->
	'use strict'

	controllers.controller 'dashboard', ['$scope', 'alerttext', 'sensorhub', 'latest', 'meta', 'search', ($scope, alerttext, sensorhub, latest, meta, search) ->

    searchParams = filtered:true, start:'60 minutes ago'

    search.gatewayEvents searchParams, (data) ->
      $scope.networkHubEvents = data

    search.sensorHubEvents searchParams, (data) ->
      $scope.sensorHubEvents = data

    search.gatewayEvents
      gatewayEventCode  : '(1 2)'
      limit             : 1
      start             : '5 years ago'
    , ( data ) ->
        $scope.latestNetworkHubPowerSource = data[0]

    sensorhub.getAll {}, (data) ->
      $scope.sensorHubs = data
      roomNamesBySensorHubMacAddress = {}
      $scope.sensorHubs.forEach (sensorHub) ->
        name = meta.roomTypes[sensorHub.roomType] || meta.sensorHubTypes[String(sensorHub.sensorHubType)]
        @[sensorHub._id] = name
      , roomNamesBySensorHubMacAddress

      $scope.roomNamesBySensorHubMacAddress = roomNamesBySensorHubMacAddress

    latest.get start:"'12 hours ago'", (data) -> $scope.latest = data

    $scope.cssClassByRssiThreshold = (rssi) ->
      return 'label-default' if rssi is undefined
      rssiNum = Number(rssi)
      switch
        when rssiNum < -95 then 'label-danger'
        when rssiNum < -80 then 'label-warning'
        else 'label-success'

    $scope.cssClassByBatteryThreshold = (battery) ->
      return 'label-default' if battery is undefined
      batteryNum = Number(battery)
      switch
        when batteryNum > 70 then 'label-success'
        when batteryNum > 49 then 'label-warning'
        else 'label-danger'

    $scope.meta = meta

    $scope.alerttext = alerttext

  ]