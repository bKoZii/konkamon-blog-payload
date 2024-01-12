# FROM node:18.8-alpine as base

# FROM base as builder

# WORKDIR /home/node/app
# COPY package*.json ./

# COPY . .
# RUN yarn install
# RUN yarn build

# FROM base as runtime

# ENV NODE_ENV=production
# ENV PAYLOAD_CONFIG_PATH=dist/payload.config.js

# WORKDIR /home/node/app
# COPY package*.json  ./
# COPY yarn.lock ./

# RUN yarn install --production
# COPY --from=builder /home/node/app/dist ./dist
# COPY --from=builder /home/node/app/build ./build

# EXPOSE 3000

# CMD ["node", "dist/server.js"]

ARG NODE_VERSION=20

# Setup the build container.
FROM node:${NODE_VERSION}-alpine AS build

WORKDIR /home/node

# Install dependencies.
COPY package*.json .

RUN yarn install

# Copy the source files.
COPY src src
COPY tsconfig.json .

# Build the application.
RUN yarn build && yarn cache clean

# Setup the runtime container.
FROM node:${NODE_VERSION}-alpine

WORKDIR /home/node

# Copy the built application.
COPY --from=build /home/node /home/node

# Expose the service's port.
EXPOSE 3000

# Run the service.
CMD ["yarn", "run", "serve"]