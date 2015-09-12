define ['ng', 's/services'], (angular, services) ->

  services.factory 'AuthTokenFactory', ( $window ) ->

    store = $window.localStorage
    key   = 'auth-token'

    getToken  : ->
      store.getItem( key )

    setToken  : ( token ) ->
      if token
        store.setItem( key, token )
        $window.addEventListener 'storage', ( storageEvent ) ->
          if storageEvent.key is key
            $window.location.reload()
      else
        store.removeItem( key )