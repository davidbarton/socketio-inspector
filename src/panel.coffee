model = new Model
model.addItem m for m in mock

port = chrome.extension.connect { name: "socketio-inspector" }
port.onMessage.addListener (msg) ->
  model.addItem msg
  appContext.setState data: model.getItems()
