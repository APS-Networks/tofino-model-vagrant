#! /usr/bin/env bash

set -e

tar xvf /tmp/bf-sde-9.7.0.tgz -C ~vagrant
cd ~vagrant/bf-sde-9.7.0/p4studio
sudo ./install-p4studio-dependencies.sh
./p4studio profile apply ~vagrant/dependencies/behavioural.yaml

chown vagrant:vagrant /home/vagrant/bf-sde-9.7.0 -R