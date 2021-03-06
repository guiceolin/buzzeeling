express  = require "express"

app = do express.createServer

app.configure ->
  app.set "views", "#{__dirname}/views"
  app.set "view engine", "jade"
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static "#{__dirname}/public"

app.configure "development", ->
  app.use express.errorHandler dumpExceptions: true, showStack: true

app.configure "production", ->
  app.use express.errorHandler()

app.listen process.env.PORT || 3000, ->
  console.log "Server listening on port %d in %s mode", app.address().port, app.settings.env

app.get "/", (req, res) ->
  res.render "index", title: "Buzzeeling"
