#!/bin/bash
export $(cat .env.production | xargs)
docker build -t w3-app -f Dockerfile.prod --build-arg SECRET_KEY_BASE .
docker tag w3-app "haroonkhalidclustox/w3-app:$TAG"
docker push "haroonkhalidclustox/w3-app:$TAG"