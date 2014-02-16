# SocketIO Inspector

This is Chrome extensions expanding DevTools by adding SocketIO Inspector tab. You can observe your socket communication in pretty format.

# How to run?

For development on your local machine, take the following steps:
* First you'll need to make sure your system has a c++ compiler. For OSX, XCode will work, for Ubuntu, the `build-essential` and `libssl-dev` packages work.
* install nvm `curl https://raw.github.com/creationix/nvm/master/install.sh | sh`
* use nvm to install node and npm `nvm install 0.10`
* install CoffeeScript and Gulp globally `npm install -g coffee-script gulp`
* install node modules `npm install`
* in shell, type `gulp develop` it builds your src files into dist dir
* Open [chrome://extensions/](chrome://extensions/)
* Check "Developer mode" at upper top corner
* Hit "Load unpacked extension..." and pick project folder
* Open DevTools and Extension Tab

# TODO:
* [kamil] are websockets working? fix them
* [david] separete web pages trafic (now I see mixed comunication from all pages in one list at each page)
* [petr+honza] filter & search - search realtime through keys and filter by event types (e.g. incoming, outgoing, subscribe, keepalive, reconnect, data)
* [honza] change orange color to some non agressive one
* [honza+david] improve UX -> limit nesting (too many tables in tables) -> show final data like plan json? -> SHOW DATA FISRT, the first I want to see is main key-value pair (args[0] and args[1]) -> green and blue colors, limit them, maybe on for top levels, not so deep, or maybe make another new tab wit only key-value pair from args
* put tabs switching to top panel
* put connection hash next to timestamp (3 lines reduced to 2)
* package it and publish on chrome market
* write tests, github static page and publish to github