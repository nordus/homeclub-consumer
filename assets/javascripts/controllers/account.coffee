define ['c/controllers', 's/customer-account', 's/user', 's/notifier'], (controllers) ->
	'use strict'

	controllers.controller 'account', ['$rootScope', '$scope', 'customeraccount', 'user', 'notifier', ($rootScope, $scope, customerAccount, user, notifier) ->

		$scope.customerAccount = new customerAccount($rootScope.currentUser)
		$scope.user = new user($rootScope.currentUser.user)

		$scope.save = ->
			$scope.user.$update()
			$scope.customerAccount.$update (customerAccount) ->
				notifier.info 'Saved!'

  ]