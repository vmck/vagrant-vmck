FROM debian:stretch

RUN set -e \
 && apt-get update \
 && apt-get install -y curl \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN set -e \
 && curl -O https://releases.hashicorp.com/vagrant/2.2.4/vagrant_2.2.4_x86_64.deb \
 && dpkg -i vagrant_2.2.4_x86_64.deb \
 && rm vagrant_2.2.4_x86_64.deb

RUN vagrant plugin install vagrant-vmck
