model = new Model

port = chrome.extension.connect { name: "socketio-inspector" }
port.onMessage.addListener (msg) ->
  model.addItem msg
  appContext.setState items: model.getItems()
