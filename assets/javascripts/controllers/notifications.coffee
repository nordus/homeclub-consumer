define ['c/controllers', 's/customer-account'], (controllers) ->
  
  controllers.controller 'notifications', ['$rootScope', '$scope', 'customeraccount', ($rootScope, $scope, customerAccount) ->
    $scope.customerAccount = new customerAccount($rootScope.currentUser)
    
    $scope.toggleNotification = (value, msgType, deliveryMethod) ->
      notificationName = "#{msgType}#{deliveryMethod}Subscriptions"
      checkedNotifications = $scope.customerAccount[notificationName]
      indexOfValue = checkedNotifications.indexOf(value)
      if indexOfValue isnt -1
        checkedNotifications.splice indexOfValue, 1
      else
        checkedNotifications.push value
      # $scope.customerAccount.$update()
  ]