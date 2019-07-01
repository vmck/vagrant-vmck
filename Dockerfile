FROM ubuntu:bionic

RUN set -e \
 && apt-get update -yqq \
 && apt-get install -yqq git procps curl rsync kmod ssh ruby ruby-dev build-essential \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN set -e \
 && curl -O https://releases.hashicorp.com/vagrant/2.2.4/vagrant_2.2.4_x86_64.deb \
 && dpkg -i vagrant_2.2.4_x86_64.deb \
 && rm vagrant_2.2.4_x86_64.deb \
 && vagrant --version

RUN mkdir /src
WORKDIR /src
ADD . .

RUN gem build vagrant-vmck.gemspec
RUN vagrant plugin install vagrant-vmck-*.gem
