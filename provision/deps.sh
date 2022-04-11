#! /usr/bin/env bash

set -e

apt-get install -y python3 python3-pip python3-venv libncurses-dev

# Allow python to create raw sockets. This is important for scapy and
# async-packet-test to open sockets. SInce this is a virtual machine we have
# complete control over, this is _mostly_ ok, but it certainly isn't 
# recommended otherwise.
setcap cap_net_raw+eip $(readlink -f $(which python3))

# For docs/jekyll
apt-get install -y ruby-dev
gem install jekyll bundler
