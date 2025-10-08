#!/bin/bash
set -e

IMAGE_NAME="akinfeayomide373/my_page:latest"
CONTAINER_NAME="my_page_container"
PORT=8085

echo "🚀 Deploying latest image: $IMAGE_NAME"

# Step 1: Pull the latest image
echo "📦 Pulling latest image from Docker Hub..."
docker pull $IMAGE_NAME

# Step 2: Stop and remove any container using the same port
OLD_CONTAINER=$(docker ps -q --filter "publish=$PORT")

if [ "$OLD_CONTAINER" ]; then
  echo "🛑 Found container using port $PORT — stopping and removing it..."
  docker stop $OLD_CONTAINER
  docker rm $OLD_CONTAINER
else
  echo "✅ No container currently using port $PORT."
fi

# Step 3: Stop and remove old container by name (if exists)
if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
  echo "🧹 Removing old container named $CONTAINER_NAME..."
  docker stop $CONTAINER_NAME >/dev/null 2>&1 || true
  docker rm $CONTAINER_NAME >/dev/null 2>&1 || true
fi

# Step 4: Start a new container
echo "🚀 Starting new container..."
docker run -d -p $PORT:8085 --name $CONTAINER_NAME $IMAGE_NAME

# Step 5: Clean up unused images
echo "🧽 Cleaning up old images..."
docker image prune -f

echo "✅ Deployment complete. Container '$CONTAINER_NAME' is now running on port $PORT."
