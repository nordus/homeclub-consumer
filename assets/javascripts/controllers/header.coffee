define ['c/controllers', 's/notifier', 's/alert-text', 'ngAnalytics'], (controllers) ->
	'use strict'

  # TODO: [DRJ] remove Pusher
	controllers.controller 'header', ['$http', '$rootScope', '$scope', 'Analytics', 'notifier', 'Pusher', 'alerttext', '$location', ($http, $rootScope, $scope, Analytics, notifier, Pusher, alerttext, $location) ->

    $rootScope.showDebug = false
    $rootScope.toggleDebug = ->
      $rootScope.showDebug = !$rootScope.showDebug

    $rootScope.$watch 'currentUser', (currentUser) ->
      unless currentUser is undefined

        Analytics.set '&uid', currentUser._id

#        gatewayId = currentUser.gateways[0]._id
#
#        Pusher.subscribe gatewayId, 'sensorHubEvent', (e) ->
#          eventResolved   = e.message.sensorEventEnd isnt 0
#          level           = if eventResolved then 'success' else 'error'
#          notificationMsg = alerttext.sensorHubEvent(e.message)
#
#          notifier[level] 'Sensor Event', notificationMsg
#
#
#        Pusher.subscribe gatewayId, 'gatewayEvent', (e) ->
#          notificationMsg = alerttext.gatewayEvent(e.message)
#
#          notifier.info 'Gateway Event', notificationMsg


    $scope.isActive = (link) ->
      $location.path().indexOf(link) is 0

    $scope.logout = ->
      $http.post('/api/logout', { logout:true }).then ->
        $rootScope.currentUser = undefined
        location.href = '/login'
  ]