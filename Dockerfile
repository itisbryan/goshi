FROM ruby:3.1.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev curl nano && \
    rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get install -y nodejs

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt update
RUN apt install -y yarn
ENV PATH $(yarn global bin):$PATH

ARG APP_DIR=/usr/src/app

ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/${BUNDLE_PATH}/bin \
    GEM_HOME=/${BUNDLE_PATH}

ENV PATH="${BUNDLE_BIN}:${PATH}"

WORKDIR $APP_DIR

COPY . $APP_DIR/

RUN chmod +x init.sh
RUN ./init.sh
RUN gem install bundler --no-document -v '2.4.12'