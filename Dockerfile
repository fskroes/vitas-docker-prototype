# pull official base image
FROM node:14.15.1 AS builder
# Set working directory
WORKDIR /app

# install app dependencies
COPY vitas-web/ ./

RUN npm install
RUN npm run-script build



FROM node:14.15.1 AS server_build
WORKDIR /root/

ENV PATH /root/node_modules/.bin:$PATH

COPY --from=builder /app/build ./build

COPY api/package*.json ./
RUN npm install

COPY api/ ./
# COPY api/bin/www ./bin/www

# start app
CMD ["node", "./bin/www"]