define ['c/controllers', 's/notifier', 's/alert-text'], (controllers) ->
	'use strict'

	controllers.controller 'header', ['$http', '$rootScope', '$scope', 'notifier', 'Pusher', 'alerttext', '$location', ($http, $rootScope, $scope, notifier, Pusher, alerttext, $location) ->
    $rootScope.$watch 'currentUser', (currentUser) ->
      unless currentUser is undefined
        gatewayId = currentUser.gateways[0]._id

        Pusher.subscribe gatewayId, 'sensorHubEvent', (e) ->
          eventResolved   = e.message.sensorEventEnd isnt 0
          level           = if eventResolved then 'success' else 'error'
          notificationMsg = alerttext.sensorHubEvent(e.message)

          notifier[level] 'Sensor Event', notificationMsg


        Pusher.subscribe gatewayId, 'gatewayEvent', (e) ->
          notificationMsg = alerttext.gatewayEvent(e.message)

          notifier.info 'Gateway Event', notificationMsg


    $scope.isActive = (link) ->
      $location.path().indexOf(link) is 0

    $scope.logout = ->
      $http.post('/api/logout', { logout:true }).then ->
        $rootScope.currentUser = undefined
        location.href = '/login'
  ]