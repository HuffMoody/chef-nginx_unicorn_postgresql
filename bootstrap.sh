#!/usr/bin/env bash
apt-get update
apt-get -y upgrade outdated
apt-get -y install build-essential zlib1g-dev libssl-dev libreadline6-dev libyaml-dev
cd /tmp
wget ftp://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p125.tar.gz
tar -xvzf ruby-1.9.3-p125.tar.gz
cd ruby-1.9.3-p125/
./configure --prefix=/usr/local
make
make install
gem install chef -v 10.24.0 --no-ri --no-rdoc
gem install ruby-shadow --no-ri --no-rdoc
mkdir /var/chef
reboot
