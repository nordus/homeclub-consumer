define ['c/controllers', 'ngAnalytics', 's/auth-token'], (controllers) ->
	'use strict'

	controllers.controller 'header', [
    '$http'
    '$rootScope'
    '$scope'
    'Analytics'
    '$location'
    'AuthTokenFactory'
    ($http, $rootScope, $scope, Analytics, $location, AuthTokenFactory) ->

      $rootScope.showDebug = false
      $rootScope.toggleDebug = ->
        $rootScope.showDebug = !$rootScope.showDebug

      $rootScope.$watch 'currentUser', (currentUser) ->
        unless currentUser is undefined

          Analytics.createAnalyticsScriptTag()
          Analytics.set '&uid', currentUser._id
          Analytics.set 'dimension1', currentUser._id
          Analytics.set 'dimension2', currentUser.carrier
          Analytics.trackPage $location.path()

      $scope.isActive = (link) ->
        $location.path().indexOf(link) is 0

      $scope.logout = ->
        $rootScope.currentUser = undefined
        AuthTokenFactory.setToken null
        location.href = '/login'
  ]