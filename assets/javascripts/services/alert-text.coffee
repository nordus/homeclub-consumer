define ['ng', 's/services'], (angular, services) ->
	'use strict'

	services.factory 'alerttext', ->

		sensorHubEvent: (message) ->
      eventResolved = message.sensorEventEnd isnt 0
      if eventResolved
        eventType = message.sensorEventEnd
      else
        eventType = message.sensorEventStart
      alertText = switch eventType
        when 1 then '<i class="icon-droplet"></i> Water detect'
        when 2 then 'Motion detect'
        when 3 then '<i class="icon-temperature"></i> Low temperature'
        when 4 then '<i class="icon-temperature"></i> High temperature'
        when 5 then '<i class="icon-droplets"></i> Low humidity'
        when 6 then '<i class="icon-droplets"></i> High humidity'
        when 7 then '<i class="icon-lamp"></i> Low light'
        when 8 then '<i class="icon-lamp"></i> High light'
      if eventResolved
        alertText += ' resolved'
      alertText

		gatewayEvent: (message) ->
		  switch message.gatewayEventCode
        when 1 then '<i class="icon-battery-full"> Going from line power to backup battery'
        when 2 then '<i class="icon-power-cord"> Going from backup battery to line power'
        when 3 then '<i class="icon-battery-half"></i> Transition from high to low battery voltage'
        when 4 then '<i class="icon-battery-empty"></i> Transition from low to critical low battery voltage'
        when 5 then '<i class="icon-power-cord"></i> Going from shipping/dead to power on (SDG connected to line power)'
        when 6 then '<i class="icon-connection"></i> Heartbeat'