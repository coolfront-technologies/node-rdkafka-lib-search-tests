FROM ubuntu:18.04

RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt-get update --fix-missing
RUN apt-get install -y gnupg
RUN apt-get install -y wget
RUN touch /etc/apt/sources.list.d/pgdg.list
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

# make sure apt is up to date
#then install any dependancies we need for build tooling
#and for special case node module dependancies. ex: postgresql-client
RUN apt-get update --fix-missing


RUN apt-get install -y curl
RUN apt-get install -y build-essential
RUN apt-get install -y libssl1.0-dev
RUN apt-get install -y libpq-dev
RUN apt-get install -y libssl1.0
RUN apt-get install -y openssl1.0
RUN apt-get install -y git
RUN apt-get install -y python
RUN apt-get install -y nano


RUN apt-get install -y nodejs

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 6.9.1

# Install nvm with node and npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default


VOLUME [ "/project" ]

WORKDIR /project

RUN bash \
    && source $NVM_DIR/nvm.sh \
