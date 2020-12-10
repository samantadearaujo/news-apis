FROM node:14.15-alpine3.12 AS js-builder

ENV NODE_ENV=prod

WORKDIR /build

RUN apk update --no-cache && \
    apk upgrade --no-cache && \
    apk add --no-cache git


COPY assets assets
RUN npm ci --prefix assets --no-audit --no-color --unsafe-perm

RUN npm run --prefix assets deploy


FROM hexpm/elixir:1.11.2-erlang-23.1.3-alpine-3.12.1 AS otp-builder

ARG APP_NAME
ARG APP_VERSION

ENV APP_NAME=${APP_NAME} \
    APP_VERSION=${APP_VERSION} \
    MIX_ENV=prod

WORKDIR /build

RUN apk update --no-cache && \
    apk upgrade --no-cache && \
    apk add --no-cache git

RUN mix local.rebar --force && \
    mix local.hex --force

COPY mix.* ./
RUN mix deps.get --only prod && \
    mix deps.compile

COPY config config
COPY lib lib
COPY priv priv
RUN mix compile

COPY --from=js-builder /build/priv/static priv/static
RUN mix phx.digest

COPY rel rel
RUN mix release

FROM alpine:3.12.1

ARG APP_NAME
ARG APP_VERSION

ENV APP_NAME=${APP_NAME} \
    APP_VERSION=${APP_VERSION}

RUN apk update --no-cache && \
    apk upgrade --no-cache && \
    apk add --no-cache bash openssl

WORKDIR /opt/elixir_boilerplate

COPY --from=otp-builder /build/_build/prod/${APP_NAME}-${APP_VERSION}.tar.gz .
RUN tar -xvzf ${APP_NAME}-${APP_VERSION}.tar.gz && \
    rm ${APP_NAME}-${APP_VERSION}.tar.gz

COPY priv/scripts/docker-entrypoint.sh /usr/local/bin
RUN chmod a+x /usr/local/bin/docker-entrypoint.sh

RUN adduser -D elixir_boilerplate && \
    chown -R elixir_boilerplate: /opt/elixir_boilerplate
USER elixir_boilerplate

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["start"]