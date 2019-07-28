FROM alpine:3.10.1

RUN apk add ruby ruby-dev ruby-bundler ruby-json rsync gcc g++ make git libc-dev openssh bash

ENV PATH=$PATH:/vagrant/exec

RUN git clone https://github.com/hashicorp/vagrant.git \
 && cd vagrant \
 && git checkout v2.2.4 \
 && bundle install \
 && bundle --binstubs exec \
 && vagrant --version

RUN mkdir /src
WORKDIR /src
ADD . .

RUN gem build vagrant-vmck.gemspec
RUN vagrant plugin install vagrant-vmck-*.gem
