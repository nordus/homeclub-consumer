define ['ng', 's/services', 'ngResource'], (angular, services) ->
  'use strict'

  services.factory 'fieldhistogram', ['$resource', '$rootScope', ($resource, $rootScope) ->

    defaultParams =
      fields                : ['sensorHubData1', 'sensorHubData2', 'sensorHubData3']
      start                 : 'august 10th at noon'
      msgType               : 5
      sensorHubMacAddresses : $rootScope.currentUser.gateways[0].sensorHubs

    $resource '/api/fieldhistograms', defaultParams

  ]