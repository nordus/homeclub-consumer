define ['c/controllers', 's/fieldhistogram'], (controllers) ->
  'use strict'

  controllers.controller 'reports', ['$filter', '$scope', 'fieldhistogram', ($filter, $scope, fieldhistogram) ->
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
      tooltip:
        formatter: ->
          [ $filter( 'date' )( @x, 'MMM dd, h:mma' )
            "<span style=\"color:#{@points[1].series.color}\">- #{@points[0].series.name}</span>: <b>#{@y.toFixed(1)}℉</b>"
            "<span style=\"color:#{@points[1].series.color}\">\u25CF #{@points[1].series.name}</span>: <b>#{@points[1].point.low.toFixed(1)}℉ - #{@points[1].point.high.toFixed(1)}℉</b>"
          ].join( '<br/>' )

  ]