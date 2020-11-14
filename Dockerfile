FROM node:15.2.0-buster-slim

LABEL author=mf@hotdoc.com.au

ENV CI true

# install chrome for default testem config
RUN \
	apt-get update &&\
	apt-get install -y chromium 

# tweak chrome to run with --no-sandbox option
RUN \
	sed -i 's/"$@"/--no-sandbox "$@"/g' /usr/bin/chromium

RUN mkdir -p /usr/src/app \
	&& useradd chrome \
	&& chown -R chrome:chrome /usr/src/app

# Run Chrome as non-privileged
USER chrome
WORKDIR /usr/src/app

ENV CHROME_BIN=/usr/bin/chromium\
	CHROME_PATH=/usr/lib/chromium/
