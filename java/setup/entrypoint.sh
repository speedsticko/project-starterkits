#!/usr/bin/env bash
## Do your own config stuff here
## this copies our settings.xml to the default place where maven will look for it.
rm -f /usr/share/maven/conf/settings.xml >/dev/null
# Always end with this line so that the CMD of the Dockerfile will be executed...cp /settings.xml /usr/share/maven/conf/settings.xml

exec "$@"
