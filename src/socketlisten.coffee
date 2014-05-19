# ABOUT
# Injected into web page js
# Overrides io "emit" and "on" events with listener
# Send catched events by chrome messages into background.js

# TODO
# How about chrom extension id? can I inject it from extension?

sendMessage = (msg) ->
  chrome.runtime.sendMessage extensionId, msg, (res) ->
    console.log res if res?

attachListener = (name, socket) ->
  fn = socket[name]
  socket[name] = (arg...) ->
    payload =
        name: name
        time: (new Date).getTime()
        socket:
          sessionid: socket.socket.sessionid
          transport: socket.socket.transport.name
          host: socket.socket.options.host
          port: socket.socket.options.port
        args: Array.prototype.slice.call arguments

    sendMessage JSON.stringify payload
    fn.apply socket, arguments

socketHack = ->
  for k, socket of io.sockets
    for e, namespace of socket.namespaces
      for name in ['emit', '$emit']
        attachListener name, namespace

# Currently works only when socketio variable name is "io"
if io?
  socketHack()
  con = io.connect
  io.connect = ->
    socketHack()
    con.apply io, arguments