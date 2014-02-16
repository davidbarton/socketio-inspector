# injected into web page js, override io emit and on event here and send events by chrome messages into background.js
# how about chrom extension id? can I inject it from extension?

sendMessage = (msg) ->
  chrome.runtime.sendMessage extensionId, msg, (res) ->
    console.log res if res?

hack = (name, socket) ->
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
        hack name, namespace


# for key, socket of io.sockets
#   _onPacket = socket.onPacket
#   socket.onPacket = () ->
#     sendMessage JSON.stringify arguments
#     _onPacket.apply this, arguments

socketHack()
con = io.connect
io.connect = ->
  socketHack()
  con.apply io, arguments