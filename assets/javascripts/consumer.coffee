require ['requirejs-config'], ->

  require [
    'ng'
    'app'
    'templates'
    'snapengage-widget'
    'c/alerts'
    'c/dashboard'
    'c/header'
    'c/reports'
    'c/account'
    'c/sensors'
    'bootstrap'
    's/auth-token'
    's/auth-interceptor'
    ], (angular, app, templates, snapengageWidget) ->

    rp = ($routeProvider) ->

      auth =
        isLoggedIn: ['$http', '$rootScope', 'AuthTokenFactory', ($http, $rootScope, AuthTokenFactory) ->
          return true if $rootScope.currentUser
          $http.get('/api/me/customer-account')
            .success (data) ->
              $rootScope.currentUser = data.account
              AuthTokenFactory.setToken data.token
              return true
            .error ->
              location.href = '/login'
        ]

      $routeProvider
        .when '/dashboard',
          controller  : 'dashboard'
          template    : templates.dashboard
          resolve: auth

        .when '/reports',
          controller  : 'reports'
          template    : templates.reports
          resolve: auth

        .when '/account',
          controller  : 'account'
          template    : templates.account
          resolve: auth

        .when '/alerts',
          controller  : 'alerts'
          template    : templates.alerts
          resolve: auth

      .when '/sensors',
        controller  : 'sensors'
        template    : templates.sensors
        resolve     : auth

      .otherwise
        redirectTo  : '/dashboard'

    app.config ['$routeProvider', rp]

    app.config [
      '$httpProvider'
      ( $httpProvider ) ->
        $httpProvider.interceptors.push 'AuthInterceptor'
    ]

    angular.bootstrap document, ['app']

    snapengageWidget()