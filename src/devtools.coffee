###
@jsx React.DOM
###
chrome.devtools.panels.create "SocketIO Inspector", "Icon.png", "panel.html", (panel) ->
chrome.devtools.network.onRequestFinished.addListener (request) ->
  if request?
    request.getContent (data, encoding) ->
      #console.log 'r', request
      console.log 'd', data
      #console.log 'e', encoding