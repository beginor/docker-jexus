#!/usr/bin/env bash
### every exit != 0 fails the script
set -e
apt-get update && apt upgrade -y
# install wget to download jexus, curl for healthcheck.
apt-get install -y wget curl
wget https://linuxdot.net/down/jexus-5.8.3.tar.gz
tar -zxf jexus-5.8.3.tar.gz
jexus-5.8.3/install
rm -rf jexus-5.8.3
rm jexus-5.8.3.tar.gz
apt-get remove -y wget
apt-get purge -y wget
apt-get autoremove -y
rm -rf /var/lib/apt/lists/*
