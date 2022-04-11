#! /usr/bin/env bash

set -e -o pipefail

pip install --upgrade pip
pip install wheel
mkdir -p ~/dependencies
cd ~/dependencies

pip install pytest gnureadline wheel

sudo setcap cap_net_raw+eip $(which pytest)

if [ ! -d bfrt-helper ]; then
    git clone https://github.com/APS-Networks/bfrt-helper
fi
cd bfrt-helper && pip3 install .
./scripts/build-docs.sh

cd ~/dependencies
if [ ! -d async-packet-test ]; then
    git clone https://github.com/CommitThis/async-packet-test
fi
cd async-packet-test && pip3 install .
cd docs
bundle install
# This site will be nested so the baseurl needs to be updated
sed -iE 's/^baseurl.*$/baseurl: async-packet-test/g' ./_local_config.yml
bundle exec jekyll build --config ./_local_config.yml

# The SDE has it's own version of Python, and it is missing some dependencies
~/bf-sde-9.7.0/install/bin/pip3.8 install six