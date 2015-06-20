Backbone = require "backbone"
_ = require 'underscore'
sd = require("sharify").data
mediator = require '../../../lib/mediator.coffee'
template = -> require('../templates/connections.jade') arguments...

module.exports = class ChannelConnectionsView extends Backbone.View

  initialize: (options)->
    @collection.on "sync", @render, @

  render: ->
    if @collection.length
      @$('.metadata__content').html template(connections: @collection.models)
      @$el.css 'display', 'inline-block'
    else
      @$el.hide()