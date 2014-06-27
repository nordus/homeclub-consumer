define (require) ->
  'use strict'

  angular = require('ng')
  angularSanitize = require('ngSanitize')

  angular.module 'controllers', ['ngSanitize']