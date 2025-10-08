#!/bin/bash

# ------------------------------
# CONFIGURATION
# ------------------------------
IMAGE_NAME="akinfeayomide373/my_page:latest"
CONTAINER_NAME="my_page_container"
PORT=8085   # Change this if your container uses a different port

# ------------------------------
# SCRIPT START
# ------------------------------
echo "🚀 Deploying latest image: $IMAGE_NAME"

# Step 1: Pull the latest image from Docker Hub
echo "📦 Pulling latest image from Docker Hub..."
docker pull $IMAGE_NAME

# Step 2: Stop and remove old container if it exists
if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
    echo "🛑 Stopping old container..."
    docker stop $CONTAINER_NAME

    echo "🧹 Removing old container..."
    docker rm $CONTAINER_NAME
fi

# Step 3: Start new container
echo "🚀 Starting new container..."
docker run -d \
  --name $CONTAINER_NAME \
  -p $PORT:8085 \
  $IMAGE_NAME

# Step 4: Clean up old dangling images (optional)
echo "🧽 Cleaning up old images..."
docker image prune -f

echo "✅ Deployment complete. Container '$CONTAINER_NAME' is now running."
