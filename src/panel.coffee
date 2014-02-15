port = chrome.extension.connect { name: "socketio-inspector" }
port.onMessage.addListener (msg) ->
  console.log 'new message: ', msg


model = new Model
model.addItem m for m in mock

setTimeout (-> appContext.setState data: model.getItems()), 500
