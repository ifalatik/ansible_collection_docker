#!/bin/bash
set -e

# Start Docker daemon in the background
/usr/bin/dockerd &

# Wait until Docker daemon is running
tries=0
max_tries=10
until docker info > /dev/null 2>&1; do
  tries=$((tries + 1))
  if [ $tries -gt $max_tries ]; then
    echo "Docker daemon failed to start."
    exit 1
  fi
  echo "Waiting for Docker daemon to start..."
  sleep 3
done

# Execute the CMD passed by Dockerfile
exec "$@"
