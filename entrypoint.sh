#!/bin/sh -

set -o errexit
set -o nounset

sleep 10

case "$1" in
  squid)
    exec squid -N
    ;;
  bastion)
    exec bastion
    ;;
  *)
    echo "Don't recognize command '$1', exiting"
    exit 1
    ;;
esac
