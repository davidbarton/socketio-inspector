id = document.createElement 'script'
id.type = 'text/javascript'
code = "var extensionId = \"#{chrome.runtime.id}\";"
try
  id.appendChild document.createTextNode(code)
catch e
  id.text = code
(document.body || document.head || document.documentElement).appendChild id

script = document.createElement 'script'
script.type = 'text/javascript'
script.src = chrome.extension.getURL "dist/socketlisten.js"
(document.body || document.head || document.documentElement).appendChild script