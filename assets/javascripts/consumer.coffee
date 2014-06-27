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
    'bootstrap'
    ], (angular, app, templates, snapengageWidget) ->

    rp = ($routeProvider) ->

      auth =
        isLoggedIn: ['$http', '$q', '$rootScope', ($http, $q, $rootScope) ->
          return true if $rootScope.currentUser
          dfd = $q.defer()
          $http.get('/api/me/customer-account')
            .success (data) ->
              $rootScope.currentUser = data
              dfd.resolve true
            .error ->
              location.href = '/login'
          dfd.promise
        ]

      $routeProvider
        .when '/',
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

        .otherwise
          redirectTo  : '/'

    app.config ['$routeProvider', rp]

    angular.bootstrap document, ['app']

    snapengageWidget()