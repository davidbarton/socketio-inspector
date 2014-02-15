script = document.createElement 'script'
script.src = chrome.extension.getURL "dist/socketlistener.js"
(document.body || document.head || document.documentElement).appendChild script