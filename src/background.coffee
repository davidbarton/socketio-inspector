ports = {};

sendToPanel = (msg) ->
  ports[key].postMessage msg for key, port of ports

chrome.extension.onConnect.addListener (port) ->
  return null if port.name isnt "socketio-inspector"
  ports[port.portId_] = port
  port.onDisconnect.addListener (port) ->
    delete ports[port.portId_]
  port.onMessage.addListener (msg) ->
    #console.log 'i have msg: ', msg
  #sendToPanel "puihiu"

chrome.runtime.onMessageExternal.addListener (msg, sender, sendResponse) ->
  sendToPanel msg