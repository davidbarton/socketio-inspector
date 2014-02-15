# injected into web page js, override io emit and on event here and send events by chrome messages into background.js
# how about chrom extension id? can I inject it from extension?

extensionId = "khjlkjekcelhjaaojagnnipeceamfeec"

sendMessage = (msg) ->
  chrome.runtime.sendMessage extensionId, msg, (res) ->
    console.log res if res?

`
(function() {
  var emit = socket.emit;
  socket.emit = function() {
    console.log('***','emit', Array.prototype.slice.call(arguments));
    emit.apply(socket, arguments);
  };
  var $emit = socket.$emit;
  socket.$emit = function() {
    console.log('***','on',Array.prototype.slice.call(arguments));
    $emit.apply(socket, arguments);
  };
})();
`

sendMessage "io:v:#{io.version}"