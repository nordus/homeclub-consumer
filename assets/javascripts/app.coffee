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
  'ngAnalytics'
  'firebase'
  ], (angular) ->

  angular.module('app', ['controllers', 'filters', 'doowb.angular-pusher', 'ngResource', 'ngRoute', 'highcharts-ng', 'services', 'angular-google-analytics', 'firebase'])
    .directive('lowerThan', [
      ->
        link = ($scope, $ele, $attrs, ctrl) ->
          validate = (viewValue) ->
            comparisonModel     = $attrs.lowerThan
            viewValueInt        = parseInt viewValue, 10
            comparisonModelInt  = parseInt comparisonModel, 10

            if isNaN(viewValueInt) or isNaN(comparisonModelInt)
              # It's valid because we have nothing to compare against
              # or one of the values is not a number
              ctrl.$setValidity 'lowerThan', true
            else
              # It's valid if model is lesser than the model we're comparing against
              ctrl.$setValidity 'lowerThan', viewValueInt < comparisonModelInt

            viewValue

          ctrl.$parsers.unshift validate
          ctrl.$formatters.push validate

          $attrs.$observe 'lowerThan', (comparisonModel) ->
            validate ctrl.$viewValue

        require:'ngModel', link:link
    ])
    .directive('greaterThan', [
      ->
        link = ($scope, $ele, $attrs, ctrl) ->
          validate = (viewValue) ->
            comparisonModel     = $attrs.greaterThan
            viewValueInt        = parseInt viewValue, 10
            comparisonModelInt  = parseInt comparisonModel, 10

            if isNaN(viewValueInt) or isNaN(comparisonModelInt)
              # It's valid because we have nothing to compare against
              # or one of the values is not a number
              ctrl.$setValidity 'greaterThan', true
            else
              # It's valid if model is greater than the model we're comparing against
              ctrl.$setValidity 'greaterThan', viewValueInt > comparisonModelInt

            viewValue

          ctrl.$parsers.unshift validate
          ctrl.$formatters.push validate

          $attrs.$observe 'greaterThan', (comparisonModel) ->
            validate ctrl.$viewValue

        require:'ngModel', link:link
    ])
    .config(['PusherServiceProvider', 'AnalyticsProvider', (PusherServiceProvider, AnalyticsProvider) ->
      PusherServiceProvider
        .setToken('f513119581ede36ac6c4')
        .setOptions({})

      AnalyticsProvider.setAccount          'UA-50394594-4'
      AnalyticsProvider.trackPages          true
      AnalyticsProvider.trackUrlParams      true
      AnalyticsProvider.useDisplayFeatures  true
      AnalyticsProvider.useAnalytics        true
      AnalyticsProvider.ignoreFirstPageLoad true
      AnalyticsProvider.delayScriptTag      true

    ])
    .run ( Analytics ) ->