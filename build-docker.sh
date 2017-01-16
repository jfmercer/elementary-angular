#!/bin/bash

# Most of this is from: https://hackernoon.com/using-yarn-with-docker-c116ad289d56

touch yarn.lock

# Init empty cache file
# if [ ! -f .yarn-cache.tgz ]; then
#   echo "Init empty .yarn-cache.tgz"
#   tar cvzf .yarn-cache.tgz --files-from /dev/null
# fi

docker build -t elementary-angular:latest .

# copies image yarn.lock into the local /tmp directory
# --entrypoint cat runs 'cat' from within the image
# --rm removes the container as soon as the command finishes
docker run --rm --entrypoint cat elementary-angular:latest /tmp/yarn.lock > /tmp/yarn.lock

# If the lock files differ, then save the images's yarn cache locally
# and save new yarn.lock locally
if ! diff -q yarn.lock /tmp/yarn.lock > /dev/null 2>&1; then
  # Compress image .yarn-cache and save to local repo
  # echo "Saving Yarn cache"
  # docker run --rm --entrypoint tar elementary-angular:latest czf - /root/.cache/yarn > .yarn-cache.tgz
  # Save new yarn.lock to local repo
  echo "Saving yarn.lock"
  cp /tmp/yarn.lock yarn.lock
fi
