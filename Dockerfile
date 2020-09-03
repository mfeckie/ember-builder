FROM alpine:3.12.0

LABEL author=mf@hotdoc.com.au

ENV CI true

RUN apk upgrade -U -a \
	&& apk add --no-cache \ 
	chromium \ 
	nodejs \
	yarn \
	&& rm -rf /var/cache/* \
	&& mkdir /var/cache/apk

RUN \
	sed -i 's/"$@"/--no-sandbox "$@"/g' /usr/bin/chromium-browser

RUN mkdir -p /usr/src/app \
	&& adduser -D chrome \
	&& chown -R chrome:chrome /usr/src/app

# Run Chrome as non-privileged
USER chrome
WORKDIR /usr/src/app

ENV CHROME_BIN=/usr/bin/chromium-browser \
	CHROME_PATH=/usr/lib/chromium/


# FROM node:10.17

# LABEL author=mf@hotdoc.com.au

# # install chrome for default testem config (as of 2.15.0)
# RUN \
#     apt-get update &&\
#     apt-get install -y \
#         apt-transport-https \
#         gnupg \
#         --no-install-recommends &&\
# 	curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - &&\
# 	curl -sL https://sentry.io/get-cli/ | bash &\
# 	echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list &&\
# 	apt-get update &&\
# 	apt-get install -y \
# 	    google-chrome-stable \
# 	    --no-install-recommends

# # tweak chrome to run with --no-sandbox option
# RUN \
# 	sed -i 's/"$@"/--no-sandbox "$@"/g' /opt/google/chrome/google-chrome

# WORKDIR /app