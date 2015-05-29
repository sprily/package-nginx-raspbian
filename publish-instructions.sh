#!/bin/sh
# A literate shell script for publishing the .deb to our repo
# To be run locally, requires access to repo.sprily.co.uk
set -e

# Configuration
# -------------

# Set the following variables prior to running
GPG_PRIVATEKEY_PASS='****'

# Copy the package to the server
# ------------------------------

scp ./nginx_1.8.0-1~squeeze_armhf.deb root@repo.sprily.co.uk:/var/aptly/

# Add the package to the repo
# ---------------------------

ssh root@repo.sprily.co.uk "sudo --set-home -u aptly aptly repo add sprily-raspbian-stable /var/aptly/nginx_1.8.0-1~squeeze_armhf.deb"

# Publish the repo
# ----------------
ssh root@repo.sprily.co.uk "sudo --set-home -u aptly aptly publish update -gpg-key=D9138756 -passphrase='$GPG_PRIVATEKEY_PASS' -batch wheezy apt/raspbian"

# Cleanup
# -------

ssh root@repo.sprily.co.uk "sudo rm /var/aptly/nginx_1.8.0-1~squeeze_armhf.deb"

echo "DONE"
