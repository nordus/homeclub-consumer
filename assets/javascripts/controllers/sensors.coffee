define ['c/controllers', 's/sensorhub', 's/notifier', 's/meta'], (controllers) ->
  'use strict'

  controllers.controller 'sensors', ['$http', '$scope', 'sensorhub', 'notifier', 'meta', ($http, $scope, sensorhub, notifier, meta) ->
    $scope.meta = meta

    sensorhub.getAll {}, (data) -> $scope.sensorHubs = data

    $scope.toggleSubscription = (sensorHub, deliveryMethod, sensorType) ->
      subscriptions = sensorHub["#{deliveryMethod}Subscriptions"]
      if sensorType in subscriptions
        subscriptions.splice subscriptions.indexOf(sensorType), 1
      else
        subscriptions.push sensorType

    $scope.forms = {}

    $scope.save = (sensorHub) ->
      sensorHub.$update (sensorHub) ->
        notifier.info 'Saved!'

    $scope.isChecked = (sensorHub, value, deliveryMethod) ->
      notificationName = "#{deliveryMethod}Subscriptions"
      checkedNotifications = sensorHub[notificationName]
      indexOfValue = checkedNotifications.indexOf(value)
      indexOfValue isnt -1

    $scope.deliveryMethods = [ 'email', 'sms' ]

    # load default thresholds from a Google Doc until they stabilize
    googleDocUrl = 'https://script.google.com/macros/s/AKfycbx4CDENbFuDaPacJkpcsLk_fCl8M-1GOMPcvBCAFOzfsUHkrUk/exec?spreadsheetKey=1gikgwIc2IdcDPECGdD1nz5E50B8Wvi9rrva93ipI8XQ&spreadsheetName=Default%20Thresholds'
    $http.get(googleDocUrl).success (data) ->
      $scope.defaultThresholds = data

      $scope.customThresholdOrDefault = (sensorHub, sensorType, minOrMax) ->
        attr = "#{sensorType}#{minOrMax}"
        sensorHub.customThresholds?[attr] || $scope.defaultThresholds[attr]

    $scope.hasSensorType = (sensorHub, sensorType) ->
      sensorTypesBySensorHubTypeId =
        '1' : ['temperature', 'water']
        '2' : ['humidity', 'light', 'temperature']
        '3' : ['motion']
        '4' : ['movement']

      sensorTypesOfCurrentSensorHub = sensorTypesBySensorHubTypeId[sensorHub.sensorHubType] || []

      sensorType in sensorTypesOfCurrentSensorHub

    $scope.sensorTypeHasMinMax = (sensorType) ->
      sensorType in ['humidity', 'light', 'temperature']

    $scope.sensorTypes = ['humidity', 'light', 'motion', 'movement', 'temperature', 'water']

  ]