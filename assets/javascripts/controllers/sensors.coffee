define ['ng', 'c/controllers', 's/gateway', 's/sensorhub', 's/notifier', 's/meta'], (angular, controllers) ->
  'use strict'

  controllers.controller 'sensors', ['$http', '$rootScope', '$scope', 'gateway', 'sensorhub', 'notifier', 'meta', ($http, $rootScope, $scope, gateway, sensorhub, notifier, meta) ->

    $scope.networkHub = gateway.get
      id:$rootScope.currentUser.gateways[0]._id

    $scope.meta = meta

    $scope.sensorHubs = sensorhub.query()

    $scope.customThresholdInputRanges =

      temperatureMin:
        min: 32
        max: 140

      temperatureMax:
        min: 32
        max: 140

      humidityMin:
        min: 0
        max: 100

      lightMin:
        min: 0
        max: 100

      lightMax:
        min: 0
        max: 999


    $scope.sensorTypes = ['humidity', 'light', 'motion', 'movement', 'temperature', 'water']

    sensorTypesBySensorHubTypeId =
      '1' : ['temperature']
      '2' : ['humidity', 'light', 'temperature']
      '3' : ['movement']
      '4' : ['motion']


    $scope.toggleSubscription = (sensorHub, deliveryMethod, sensorType) ->
      subscriptions = sensorHub["#{deliveryMethod}Subscriptions"]
      if sensorType in subscriptions
        subscriptions.splice subscriptions.indexOf(sensorType), 1
      else
        subscriptions.push sensorType


    $scope.hasSensorType = (sensorHub, sensorType) ->

      sensorTypesOfCurrentSensorHub = sensorTypesBySensorHubTypeId[sensorHub.sensorHubType] || []

      sensorType in sensorTypesOfCurrentSensorHub


    $scope.forms = {}

    $scope.save = (sensorHub) ->

      form        = $scope.forms[sensorHub._id]
      formDirty   = form.$dirty
      sensorTypesOfCurrentSensorHub = sensorTypesBySensorHubTypeId[sensorHub.sensorHubType]

      if formDirty
        sensorHub.$update (sensorHub) ->
          notifier.info 'Saved!'

      # if pendingOutboundCommand return after updating sensorHub
      return if $scope.networkHub.pendingOutboundCommand

      deviceThresholdsChanged = sensorTypesOfCurrentSensorHub.some ( sensorType ) ->
        form[ sensorType + 'Min' ].$dirty or form[ sensorType + 'Max' ].$dirty

      if deviceThresholdsChanged

        params =
          sensorHubMAC  : sensorHub._id
          networkHubMAC : $rootScope.currentUser.gateways[0]._id
          action        : sensorHub.sensorHubType

        # add changed OR default value of each threshold to params
        $scope.sensorTypes.forEach ( sensorType ) ->

          if sensorType is 'movement'
            defaultValue  = 255
            keys          = [ 'movementSensitivity' ]
          else
            defaultValue  = 65535
            keys          = [ "#{sensorType}Min", "#{sensorType}Max" ]

          keys.forEach ( k ) ->
            params[ k ] = if $scope.hasSensorType( sensorHub, sensorType ) && form[ k ].$dirty
              sensorHub.deviceThresholds[ k ]
            else
              defaultValue

        $http.post('/api/hc2',
          formInputs  : params
        ).success (data) ->
          $scope.networkHub.pendingOutboundCommand = data._id

          if data.pendingCommandAlreadyInProgress
            notifier.info 'Device update already in progress'
          else
            notifier.success 'Device update initiated'


    $scope.isChecked = (sensorHub, value, deliveryMethod) ->
      notificationName = "#{deliveryMethod}Subscriptions"
      checkedNotifications = sensorHub[notificationName]
      indexOfValue = checkedNotifications.indexOf(value)
      indexOfValue isnt -1

    $scope.deliveryMethods = [ 'email', 'sms' ]


    $scope.sensorTypeHasMinMax = (sensorType) ->
      sensorType in ['humidity', 'light', 'temperature']

  ]