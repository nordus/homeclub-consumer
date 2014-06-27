define ['ng', 's/services', 'ngResource'], (angular, services) ->
	'use strict'

	services.factory 'user', ['$resource', ($resource) ->

		$resource '/api/users/:id', id:'@_id',
			update:
				method: 'PUT'


	]