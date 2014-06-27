define [
  'ng'
  'c/controllers'
  'ngPusher'
  'ngResource'
  'ngRoute'
  'highcharts'
  'highcharts-ng'
  's/services'
  'f/filters'
  ], (angular) ->

  angular.module('app', ['controllers', 'filters', 'doowb.angular-pusher', 'ngResource', 'ngRoute', 'highcharts-ng', 'services'])
    .config ['PusherServiceProvider', (PusherServiceProvider) ->
      PusherServiceProvider
        .setToken('f513119581ede36ac6c4')
        .setOptions({})
    ]