#!/usr/bin/env bash
## Do your own config stuff here

export JAVA_HOME=$(update-alternatives --list | grep java_sdk_openjdk | cut -f3)

# Always end with this line so that the CMD of the Dockerfile will be executed...
exec "$@"
