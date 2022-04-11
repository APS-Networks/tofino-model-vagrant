#! /usr/bin/env bash

set -e

cd /tmp/docs

mkdir -p /var/www/html
mkdocs build --site-dir /var/www/html
sudo cp -R /home/vagrant/dependencies/async-packet-test/docs/_site \
        /var/www/html/async-packet-test
sudo cp -R /home/vagrant/dependencies/bfrt-helper/docs/_build/html \
        /var/www/html/bfrt-helper