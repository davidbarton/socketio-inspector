# injected into web page js, override io emit and on event here and send events by chrome messages into background.js
# how about chrom extension id? can I inject it from extension?

sendMessage = (msg) ->
  chrome.runtime.sendMessage extensionId, msg, (res) ->
    console.log res if res?

do ->
  emit = socket.emit
  socket.emit = (arg...) ->
    console.log '***','emit', Array.prototype.slice.call arguments
    emit.apply socket, arg
  $emit = socket.$emit
  socket.$emit (arg...) ->
    console.log '***','on',Array.prototype.slice.call arguments
    $emit.apply socket, arg

setTimeout () ->
  sendMessage "io:v:#{io.version}"
, 10000
