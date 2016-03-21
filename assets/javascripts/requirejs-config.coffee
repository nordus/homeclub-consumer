requirejs.config

  urlArgs: "b=#{(new Date()).getTime()}"
  
  paths:
    jquery      : 'vendor/jquery/jquery'
    ng          : 'vendor/angular/angular'
    ngPusher    : 'angular-pusher'
    ngResource  : 'vendor/angular-resource/angular-resource'
    ngRoute     : 'vendor/angular-route/angular-route'
    ngSanitize  : 'vendor/angular-sanitize/angular-sanitize'
    templates   : 'consumer-templates'
    bootstrap   : 'vendor/bootstrap/bootstrap'
    c           : 'controllers'
    f           : 'filters'
    s           : 'services'
    highcharts  : 'vendor/highcharts/highcharts'
    'highcharts-more' : 'vendor/highcharts/highcharts-more'
    'highcharts-ng' : 'vendor/highcharts-ng/highcharts-ng'
    lodash      : 'vendor/lodash/lodash.compat'
    toastr      : 'vendor/toastr/toastr'
    ngAnalytics : 'vendor/angular-google-analytics/angular-google-analytics.min'
    firebase    : 'vendor/firebase/firebase'
    angularFire : 'vendor/angularfire/angularfire'

  shim:
    ng:
      exports: 'angular'
    bootstrap   : ['jquery']
    ngPusher    : ['ng']
    ngResource  : ['ng']
    ngRoute     : ['ng']
    ngSanitize  : ['ng']
    highcharts  : ['jquery']
    'highcharts-more': ['highcharts']
    'highcharts-ng' : ['ng', 'highcharts', 'highcharts-more']
    toastr      : ['jquery']
    ngAnalytics : ['ng']
    firebase    : ['ng']
    angularFire : ['ng', 'firebase']