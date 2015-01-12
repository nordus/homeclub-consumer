define ['c/controllers', 's/sensorhub', 's/customer-account', 's/user', 's/notifier', 's/meta'], (controllers) ->
  'use strict'

  controllers.controller 'sensors', ['$rootScope', '$scope', 'sensorhub', 'customeraccount', 'user', 'notifier', 'meta', ($rootScope, $scope, sensorhub, customerAccount, user, notifier, meta) ->
    $scope.meta = meta

    sensorhub.getAll {}, (data) -> $scope.sensorHubs = data

    $scope.customerAccount = new customerAccount($rootScope.currentUser)
    unless $scope.customerAccount.mutedSensorCategories
      $scope.customerAccount.mutedSensorCategories = {}

    $scope.mutedCategories = (shMacAddress) ->
      $scope.customerAccount.mutedSensorCategories[shMacAddress] || []

    $scope.checkIfMuted = (shMacAddress, category) ->
      mutedCategories = $scope.mutedCategories(shMacAddress)
      category in mutedCategories

    $scope.categoryIsNotMuted = (shMacAddress, category) ->
      isMuted = $scope.checkIfMuted(shMacAddress, category)
      !isMuted

    $scope.toggleMuted = (shMacAddress, category) ->
      mutedCategories = $scope.mutedCategories(shMacAddress)
      if category in mutedCategories
        $scope.customerAccount.mutedSensorCategories[shMacAddress].splice mutedCategories.indexOf(category), 1
      else
        unless $scope.customerAccount.mutedSensorCategories[shMacAddress]
          $scope.customerAccount.mutedSensorCategories[shMacAddress] = []
        $scope.customerAccount.mutedSensorCategories[shMacAddress].push category

    $scope.sensorHubName = (sensorHub) ->
      meta.roomTypes[sensorHub.roomType] || meta.sensorHubTypes[sensorHub.sensorHubType]

    $scope.save = ->
      $scope.loading = true
      $scope.sensorHubs.forEach (sensorHub) ->
        sensorHub.$update()
      $scope.customerAccount.$update (customerAccount) ->
        notifier.info 'Saved!'
        $scope.loading = false

  ]