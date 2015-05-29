#!/bin/sh
# A literate shell script for building nginx 1.8 on raspbian
# To be run on the raspberry pi.  Requires `sudo` rights.
set -e

# Add nginx apt repo
# ------------------

# First add the nginx repo
echo "deb-src http://nginx.org/packages/debian/ squeeze nginx" | sudo tee /etc/apt/sources.list.d/nginx.list

# Then we need to trust the signing key
wget -O - http://nginx.org/keys/nginx_signing.key | sudo apt-key add -

# update apt, and install necessary build packages
sudo apt-get update
sudo apt-get build-dep nginx
sudo apt-get install debhelper libssl-dev libpcre3-dev

# Build the package
# -----------------

mkdir -p src
cd src
apt-get source nginx
cd nginx-1.8.0
dpkg-buildpackage -uc -b

# The .deb file should now be available one level up
cd ..

echo "DONE"
