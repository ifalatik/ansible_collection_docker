#!/bin/bash -eu

# Nested Docker can fail with overlay-based drivers depending on host kernel/filesystem.
# Default to vfs for molecule stability, but allow overriding via environment.
DOCKERD_STORAGE_DRIVER="${DOCKERD_STORAGE_DRIVER:-vfs}"

# Start Docker daemon in the background
/usr/bin/dockerd --storage-driver "${DOCKERD_STORAGE_DRIVER}" &

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
