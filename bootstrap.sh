#!/bin/bash

# install packages
apt-get -y update
apt-get -y install \
    ack-grep build-essential git curl \
    imagemagick postgresql-9.1 postgresql-client-9.1 erlang-nox

echo

# setup database
echo Check for zotonic database user
echo \\dg | sudo -u postgres psql | grep zotonic
if [ 0 -ne $? ]; then
    cat | sudo -u postgres psql <<EOF
CREATE USER zotonic with password 'secret';
EOF
fi

echo

echo Check for zotonic database
echo \\l | sudo -u postgres psql | grep zotonic
if [ 0 -ne $? ]; then
    cat | sudo -u postgres psql <<EOF
CREATE DATABASE zotonic WITH
OWNER zotonic
ENCODING 'UTF-8'
LC_CTYPE 'en_US.utf8'
LC_COLLATE 'en_US.utf8'
TEMPLATE template0;
-- Create the schema for the tutorial site
\c zotonic
CREATE SCHEMA tutorial;
ALTER SCHEMA tutorial OWNER TO zotonic;
EOF
fi

# cloning and building zotonic
cd /vagrant
git clone http://github.com/zotonic/zotonic

cd zotonic

# symlink the tutorial website into zotonic's config
(cd priv/sites && ln -s ../../../tutorial)

# now build it
make

# and start!
bin/zotonic start

echo Bootstrap done.

