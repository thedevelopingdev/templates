#!/bin/bash

# usage:
# * ./build.sh <path to ssh key> <ssh username and host>
# * must have a file called VERSION with the version number, e.g.
#   $ cat VERSION
#   0.1.2

set -e # exit if any command fails

SSH_KEY=$1
SSH_DEST=$2
image="flask-hello-world"

# list current docker images
docker images "$image"

read -r tag < VERSION
echo "Tag: $tag"
read -p "confirm correct tag (y): " confirm

if [ $confirm != "y" ]; then
    echo "User did not confirm tag, exiting..."
    exit 1
fi

docker buildx build --load --platform linux/amd64 -t "$image:$tag" .

echo "Uploading to remote host ($SSH_DEST): $image:$tag"

docker save "$image:$tag" | pv | ssh -i "$SSH_KEY" "$SSH_DEST" "cat >/tmp/temp.tar && k3s ctr images import /tmp/temp.tar --digests"