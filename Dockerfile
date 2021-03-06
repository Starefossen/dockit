FROM iojs:1-slim

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json /usr/src/app/
RUN npm install --loglevel info
COPY . /usr/src/app

CMD [ "npm", "start" ]

