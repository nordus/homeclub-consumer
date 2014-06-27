requirejs.config

  urlArgs: "b=#{(new Date()).getTime()}"
  
  paths:
    jquery      : 'vendor/jquery/jquery'
    ng          : 'vendor/angular/angular'
    ngPusher    : 'vendor/angular-pusher/angular-pusher'
    ngResource  : 'vendor/angular-resource/angular-resource'
    ngRoute     : 'vendor/angular-route/angular-route'
    ngSanitize  : 'vendor/angular-sanitize/angular-sanitize'
    templates   : 'consumer-templates'
    bootstrap   : 'vendor/bootstrap/bootstrap'
    c           : 'controllers'
    f           : 'filters'
    s           : 'services'
    highcharts  : 'vendor/highcharts/highcharts'
    lodash      : 'vendor/lodash/lodash.compat'
    toastr      : 'vendor/toastr/toastr'

  shim:
    ng:
      exports: 'angular'
    bootstrap   : ['jquery']
    ngPusher    : ['ng']
    ngResource  : ['ng']
    ngRoute     : ['ng']
    ngSanitize  : ['ng']
    highcharts  : ['jquery']
    'highcharts-ng' : ['ng', 'highcharts']
    toastr      : ['jquery']