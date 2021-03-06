{ defer } = require 'underscore'
Backbone = require 'backbone'
template = -> require('./index.jade') arguments...

module.exports = class OnboardingWelcomeSceneView extends Backbone.View
  className: 'OnboardingWelcome'

  events:
    'click .js-next': 'next'

  initialize: ({ @state, @user }) -> #

  next: (e) ->
    e.preventDefault()

    @state.next()

  render: ->
    @$el.html template
      user: @user.toJSON()

    defer => @$el.addClass "#{@className}--active"

    this
