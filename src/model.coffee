class Model

  constructor: ->
    @items = []

  addItem: (data) ->
    @items.push new ModelItem data
    i.setFriends @items for i in @items

  clear: ->
    @items = []

  getItems: ->
    @items


class ModelItem

  constructor: (data) ->
    @rawData = data
    @friends = []

  getId: ->
  # @rawData.neco..
    6

  getData: ->
    @rawData

  setFriends: (items) ->
    for i in items
      continue if i is @
      # @friends.push i.getData() if i.getId() is @getId()
