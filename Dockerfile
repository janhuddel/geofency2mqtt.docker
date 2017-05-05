FROM mhart/alpine-node:6

MAINTAINER Jan Rohwer <jan.rohwer@gmail.com>

RUN apk update && apk --no-cache add git

# install geofency2mqtt
ADD https://api.github.com/repos/janhuddel/geofency2mqtt/git/refs/heads/master /tmp/version.json
RUN mkdir /opt && cd /opt && git clone -bmaster https://github.com/janhuddel/geofency2mqtt.git
ENV APP_DIR=/opt/geofency2mqtt
WORKDIR $APP_DIR
RUN npm install

EXPOSE 80

# ensure you have a link to a mqtt-instance with name 'mqtt'
CMD ["node", "server.js", "--http-log", "--mqtt-server=mqtt"]
