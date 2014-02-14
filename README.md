# SocketIO Inspector

This is Chrome extensions expanding DevTools by adding SocketIO Inspector tab. You can observe your socket communication in pretty format.

# How to run?

For development on your local machine, take the following steps:
* First you'll need to make sure your system has a c++ compiler. For OSX, XCode will work, for Ubuntu, the `build-essential` and `libssl-dev` packages work.
* install nvm `curl https://raw.github.com/creationix/nvm/master/install.sh | sh`
* use nvm to install node and npm `nvm install 0.10`
* install CoffeeScript and Gulp globally `npm install -g coffee-script gulp`
* install node modules `npm install`
* in shell, type `gulp develop` it build your src files into dist dir
* Open [chrome://extensions/](chrome://extensions/)
* Check "Developer mode" at upper top corner
* Hit "Load unpacked extension..." and pick project folder
* Open DevTools and Extension Tab