Backbone = require "backbone"
_ = require 'underscore'
sd = require("sharify").data
mediator = require '../../../lib/mediator.coffee'
analytics = require '../../../lib/analytics.coffee'

module.exports = class PremiumView extends Backbone.View

  events:
    'click .button--add': 'openCheckout'

  initialize: ->
    @handler = StripeCheckout.configure
      key: sd.STRIPE_PUBLISHABLE_KEY
      image: 'https://s3.amazonaws.com/stripe-uploads/acct_14Lg6j411YkgzhRMmerchant-icon-1432502887007-arena-mark.png'
      token: @handleToken
      bitcoin: true
      email: sd.CURRENT_USER.email

  openCheckout: (e) =>
    @handler.open
      name: 'Are.na'
      description: '1 year / Premium subscription'
      amount: 4500

    @$('.premium--status').addClass('is-active')

    e.preventDefault()

  handleToken: (token) =>
    @$('.premium--status .inner').text "Registering your premium account..."
    $.ajax
      url: "#{sd.API_URL}/charges"
      type: 'POST'
      data: stripeToken: token
      success: (response) =>
        @$('.premium--status').addClass('is-successful')
        @$('.premium--status .inner').text "Registration successful."
        analytics.track.submit 'User paid for pro account'
        $.ajax
          url: '/me/refresh'
          type: 'GET'
          beforeSend: (xhr)->
            xhr.setRequestHeader 'X-AUTH-TOKEN', sd.CURRENT_USER?.authentication_token
          success: ->
            location.reload()
      error: (response) =>
        analytics.exception "Error registering pro account: #{response}"
        @$('.premium--status').addClass('is-error')
        @$('.premium--status .inner').text "Sorry, error registering your account, please try again."
        setTimeout (=> @$('.premium--status').removeClass('is-active')), 2000