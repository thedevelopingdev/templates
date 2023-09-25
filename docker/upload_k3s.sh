#!/bin/bash

# usage:
# * ./upload_k3s.sh <path to ssh key> <ssh username and host> <image:tag>
# * must have a file called VERSION with the version number, e.g.
#   $ cat VERSION
#   0.1.2

set -e # exit if any command fails

SSH_KEY=$1
SSH_DEST=$2
IMAGE_TAG=$3

echo "Uploading to remote host ($SSH_DEST): $IMAGE_TAG"

docker save "$IMAGE_TAG" | pv | ssh -i "$SSH_KEY" "$SSH_DEST" "cat >/tmp/temp.tar && k3s ctr images import /tmp/temp.tar --digests"
