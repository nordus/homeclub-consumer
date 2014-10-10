define ['c/controllers', 's/fieldhistogram'], (controllers) ->
  'use strict'

  controllers.controller 'reports', ['$scope', 'fieldhistogram', ($scope, fieldhistogram) ->
    $scope.formatId = (str) ->
      str.replace(/\(|\)/g, '').replace(/\s/g, '_')

    $scope.replaceChartData = (start) ->
      if start in ['1 month ago', '6 months ago']
        $scope.searchParams.interval = 'day'
      else
        $scope.searchParams.interval = 'hour'
      fieldhistogram.get $scope.searchParams, (data) -> $scope.chartData = data

    $scope.searchParams =
      start			: '1 day ago'

    $scope.$watch 'searchParams.start', (newValue) ->
      $scope.replaceChartData newValue

    Highcharts.setOptions
      global:
        useUTC: false


  ]