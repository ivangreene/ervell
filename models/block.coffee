#
# Model for a single block
#

Base = require "./base.coffee"
sd = require("sharify").data

module.exports = class Block extends Base

  url: -> "#{sd.API_URL}/blocks/#{@id}"

  title: ->
    if @has('username')
      @get('username')
    else
      @get('title')

  resizeImage: (width = 330, height = 330)->
    "http://images.are.na/resize/#{width}/#{height}/#{encodeURIComponent(@getImageSize('display'))}"

  getImageSize: (size) ->
    if @has('image')
      @get('image')?[size]?.url

  getVisibility: ->
    if @get('class') is 'Channel'
      @get('status')
    else
      @get('visibility')

  getHref: ->
    if @get('class') is 'Channel'
      "/#{@get('user').slug}/#{@get('slug')}"
    else if @get('class') is 'User'
      "/#{@get('slug')}"
    else
      "/block/#{@id}"