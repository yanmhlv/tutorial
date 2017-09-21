FROM node:5.8.0

WORKDIR /app

COPY package.json /app/package.json
COPY package-lock.json /app/package-lock.json
COPY gulpfile.js /app/gulpfile.js
RUN npm install

COPY ./views /app/views
RUN npm run gulp


FROM golang:1.8

ARG NAME
ARG VERSION

ENV NAME=${NAME} VERSION=${VERSION}

WORKDIR /app
COPY --from=0 /app/compiled/ /app/compiled
COPY main.go /go/src/app/main.go

RUN go install app && cp /go/bin/app /app
CMD /go/bin/app
