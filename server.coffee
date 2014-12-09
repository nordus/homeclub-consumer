express = require 'express'
engines = require 'consolidate'
#routes  = require './routes'

favicon         = require 'static-favicon'
bodyParser      = require 'body-parser'
methodOverride  = require 'method-override'
compress        = require 'compression'
errorHandler    = require 'errorhandler'

envConfig       = require './server/config/env-config'

exports.startServer = (config, callback) ->

  port = config.server.port or process.env.PORT

  app = express()
  server = config.httpServer || app.listen port, ->
    console.log "Express server listening on port %d in %s mode", server.address().port, app.settings.env

  #app.configure ->
  app.set 'port', port
  #app.set 'views', config.server.views.path
  app.set 'views', "#{envConfig.rootPath}/views"
  app.engine config.server.views.extension, engines[config.server.views.compileWith]
  app.set 'view engine', config.server.views.extension
  app.use favicon()
  #app.use express.urlencoded()
  #app.use express.json()
  app.use methodOverride()
  app.use compress()
  #app.use config.server.base, app.router
  app.use express.static(config.watch.compiledDir)

  #app.configure 'development', ->
  if app.get('env') is 'development'
    app.use errorHandler()

  viewOptions =
    reload:    if config.liveReload?.enabled? then config.liveReload.enabled
    optimize:  config.isOptimize ? false
    cachebust: if process.env.NODE_ENV isnt "production" then "?b=#{(new Date()).getTime()}" else ''

  router = express.Router()
  router.route('*').get (req, res) -> res.render 'index', viewOptions
  app.use router

  
  if callback
    callback(server)
  else
    if config.liveReload && config.liveReload.additionalDirs
      config.liveReload.additionalDirs = config.liveReload.additionalDirs.concat [
        "#{envConfig.rootPath}public/javascripts"
        "#{envConfig.rootPath}views"
      ]
    return app
    