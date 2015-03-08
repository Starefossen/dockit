    request = require 'request'

    Docker = module.exports = (opts) ->
      throw new Error 'Docker.opts.socket undefined' if not opts.socket

      @socket = "http://unix:#{opts.socket}:"

      @

    Docker.prototype.getContainers = (cb) ->
      request uri: "#{@socket}/containers/json", json: true, cb

    Docker.prototype.getImages = (cb) ->
      request uri: "#{@socket}/images/json", json: true, cb

    Docker.prototype.container = (cid) ->
      new Container @, cid: cid

    Container = module.exports.Container = (@docker, opts) ->
      throw new Error 'Container.docker udnefined' if not @docker
      throw new Error 'Container.opts.cid undefined' if not opts.cid

      @cid = opts.cid
      @socket = "#{@docker.socket}/containers/#{@cid}"

      @

    Container.prototype.getStats = (cb) ->
      req = request uri: "#{@socket}/stats"
      return req if typeof cb is 'undefined'

      cnt = 0
      end = (err, data) ->
        req.abort()
        cb err, data if ++cnt is 1

      req.on 'data', (data) ->
        try
          end null, JSON.parse data
        catch error
          end error

      req.on 'error', end

