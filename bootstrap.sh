#!/bin/bash

# install packages
apt-get -y update
apt-get -y install \
    ack-grep build-essential git curl \
    imagemagick postgresql-9.1 postgresql-client-9.1 \
    erlang-base erlang-tools erlang-parsetools erlang-inets \
    erlang-ssl erlang-eunit erlang-dev erlang-xmerl

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
# optional: if you have multiple sites running on the same db
\c zotonic
CREATE SCHEMA test_site;
ALTER SCHEMA test_site OWNER TO zotonic;
EOF
fi

echo Bootstrap done.

# intially, you might want to clone zotonic here too: git clone http://github.com/zotonic/zotonic
