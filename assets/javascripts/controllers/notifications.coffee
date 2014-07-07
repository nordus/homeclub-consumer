define ['c/controllers', 's/customer-account'], (controllers) ->
  
  controllers.controller 'notifications', ['$rootScope', '$scope', 'customeraccount', ($rootScope, $scope, customerAccount) ->
    $scope.customerAccount = new customerAccount($rootScope.currentUser)

    $scope.sensorHubEvents = [
      value:1, name:'Water detect'
    ,
      value:2, name:'Motion detect'
    ,
      value:3, name:'Low temperature'
    ,
      value:4, name:'High temperature'
    ,
      value:5, name:'Low humidity'
    ,
      value:6, name:'High humidity'
    ,
      value:7, name:'Low light'
    ,
      value:8, name:'High light'
    ]

    $scope.deliveryMethods = [
      icon:'icon-at', name:'Email'
    ,
      icon:'icon-mobile', name:'Sms'
    ]

    $scope.isChecked = (value, msgType, deliveryMethod) ->
      notificationName = "#{msgType}#{deliveryMethod}Subscriptions"
      checkedNotifications = $scope.customerAccount[notificationName]
      indexOfValue = checkedNotifications.indexOf(value)
      indexOfValue isnt -1
    
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