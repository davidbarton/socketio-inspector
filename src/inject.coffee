script = document.createElement 'script'
script.src = chrome.extension.getURL "dist/socketlisten.js"
(document.body || document.head || document.documentElement).appendChild script