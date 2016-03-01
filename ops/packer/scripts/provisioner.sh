#!/bin/bash

sudo wget http://apt.puppetlabs.com/puppetlabs-release-trusty.deb
sudo dpkg -i puppetlabs-release-trusty.deb
sudo apt-get -y update
sudo apt-get -y install puppet
sudo apt-get -y install unzip make git curl vim g++ libkrb5-dev