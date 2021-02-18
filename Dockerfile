# Source: https://github.com/cypress-io/cypress-docker-images/blob/master/browsers/node12.18.3-chrome87-ff82/Dockerfile

FROM cypress/base:latest

USER root

# "fake" dbus address to prevent errors
# https://github.com/SeleniumHQ/docker-selenium/issues/87
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null

# Add zip utility - it comes in very handy
RUN apt-get update && apt-get install -y zip

# add codecs needed for video playback in firefox
# https://github.com/cypress-io/cypress-docker-images/issues/150
RUN apt-get install mplayer -y

# install Firefox browser
ARG FIREFOX_VERSION=85.0.2
RUN wget --no-verbose -O /tmp/firefox.tar.bz2 https://download-installer.cdn.mozilla.net/pub/firefox/releases/$FIREFOX_VERSION/linux-x86_64/en-US/firefox-$FIREFOX_VERSION.tar.bz2 \
  && tar -C /opt -xjf /tmp/firefox.tar.bz2 \
  && rm /tmp/firefox.tar.bz2 \
  && ln -fs /opt/firefox/firefox /usr/bin/firefox

# a few environment variables to make NPM installs easier
# good colors for most applications
ENV TERM xterm
# avoid million NPM install messages
ENV npm_config_loglevel warn
# allow installing when the main user is root
ENV npm_config_unsafe_perm true
