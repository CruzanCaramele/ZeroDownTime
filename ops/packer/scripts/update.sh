#!/bin/bash -eux

apt-get -y update

apt-get -y upgrade

apt-get -y install aptitude

# ensure the correct kernel headers are installed
aptitude -y install linux-headers-$(uname -r)
# fix broken dependencies
apt-get -y -f install
# update package index on boot
cat <<EOF > /etc/init/refresh-apt.conf
description "update package index"
start on networking
task
exec /usr/bin/apt-get update
EOF

# install curl to fix broken wget while retrieving content from secured sites
aptitude -y install curl

# install general purpose packages
# install rsync
aptitude -y install rsync

# install screen
aptitude -y install screen

# install git
echo "Installing git"
aptitude -y install git
