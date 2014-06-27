define ['c/controllers', 's/search'], (controllers) ->
	'use strict'

	controllers.controller 'reports', ['$scope', 'search', ($scope, search) ->

		Highcharts.setOptions
		  global:
		    useUTC: false

		chartConfig =
			options:
				chart:
					type: 'line'
			xAxis:
				type: 'datetime'
			
		$scope.tempChartConfig			= angular.extend
			title:
				text: 'Temp'
			yAxis:
				title:
					text: 'Fahrenheit'
		, chartConfig
					
		$scope.lightChartConfig			= angular.extend
			title:
				text: 'Light'
			yAxis:
				title:
					text: 'Lux'
				type: 'logarithmic'
				minorTickInterval: 0.1
		, chartConfig
					
		$scope.humidityChartConfig	= angular.extend
			title:
				text: 'Humidity'
			yAxis:
				title:
					text: '%'
		, chartConfig

		$scope.replaceChartData = (searchParams = {}) ->
			
			search.sensorHubData searchParams, (chartData) ->
				
				$scope.tempChartConfig.series	= chartData['temp'].series

				if String(searchParams.sensorHubType) is '2'
					$scope.lightChartConfig.series		= chartData['light'].series
					$scope.humidityChartConfig.series	= chartData['humidity'].series

		$scope.searchParams =
			highchartFormat	: true
			sensorHubType		: '2'
			start						: '1 day ago'
		
		$scope.$watchCollection 'searchParams', (newValue) ->
			$scope.replaceChartData newValue

	]