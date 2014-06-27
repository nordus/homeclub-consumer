define ['c/controllers', 's/sensorhub', 's/customer-account', 's/user', 's/notifier', 's/meta'], (controllers) ->
	'use strict'

	controllers.controller 'account', ['$rootScope', '$scope', 'sensorhub', 'customeraccount', 'user', 'notifier', 'meta', ($rootScope, $scope, sensorhub, customerAccount, user, notifier, meta) ->
		$scope.meta = meta

		sensorhub.getAll {}, (data) ->
			$scope.sensorHubs = data

			$scope.everySensorHubHasARoomType = (sensorHubs) ->
				sensorHubs.every (ele, idx, arr) -> ele.roomType isnt null
	
			$scope.everySensorHubHasAWaterSource = (sensorHubs) ->
				trueOrFalse = sensorHubs.every (ele, idx, arr) ->
					isComfortDirector = ele.sensorHubType is 2
					return true if isComfortDirector
					waterSourceIsDefined = Boolean(ele.waterSource)
					return waterSourceIsDefined
				trueOrFalse

		$scope.customerAccount = new customerAccount($rootScope.currentUser)
		$scope.user = new user($rootScope.currentUser.user)

		$scope.save = ->
			$scope.sensorHubs.forEach (sensorHub) ->
				sensorHub.$update()
			$scope.user.$update()
			$scope.customerAccount.$update (customerAccount) ->
				notifier.info 'Saved!'

  ]