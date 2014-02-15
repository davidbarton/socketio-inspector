# injected into web page js, override io emit and on event here and send events by chrome messages into background.js
# how about chrom extension id? can I inject it from extension?

sendMessage = (msg) ->
  chrome.runtime.sendMessage extensionId, msg, (res) ->
    console.log res if res?

hack = (name, socket) ->
  fn = socket[name]
  socket[name] = (arg...) ->
    sendMessage JSON.stringify arg
    fn.apply socket, arguments

socketHack = ->
  for k, socket of io.sockets
    for e, namespace of socket.namespaces
      for name in ['emit', '$emit']
        hack name, namespace

socketHack()
con = io.connect
io.connect = ->
  socketHack()
  con.apply io, arguments