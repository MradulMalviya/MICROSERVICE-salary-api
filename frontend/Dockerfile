FROM node:latest

MAINTAINER Opstree Solutions

COPY . /app

WORKDIR /app/

RUN apt-get update -y && \
    apt-get install git -y

RUN npm install

ENV NODE_OPTIONS="--openssl-legacy-provider"

RUN npm run build

RUN yarn global add serve

EXPOSE 3000

ENTRYPOINT ["serve", "-s", "build"]
