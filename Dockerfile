FROM golang:1.22-alpine as go_build
WORKDIR /build
COPY . .
RUN go run mage.go -v

FROM node:14-alpine as node_build
WORKDIR /build
COPY package.json yarn.lock ./
RUN yarn --frozen-lockfile
COPY . .
RUN yarn build

FROM grafana/grafana:11.0.0
ARG PLUGINS_NAME
ENV GF_PLUGINS_ALLOW_LOADING_UNSIGNED_PLUGINS=${PLUGINS_NAME}
COPY --from=go_build /build/dist /var/lib/grafana/plugins
COPY --from=node_build /build/dist /var/lib/grafana/plugins
