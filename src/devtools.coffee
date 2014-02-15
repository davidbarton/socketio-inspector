console.log "extension id: #{chrome.runtime.id}"

chrome.devtools.panels.create "SocketIO Inspector", "Icon.png", "panel.html", (panel) ->
