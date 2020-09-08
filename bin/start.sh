#!/bin/bash

cd $(dirname $0)/..

DEPLOY_NODE_WEB="node.hostname != notuse" \
DEPLOY_NODE_DB="node.hostname != notuse" \

DEPLOY_NODE_WEB="node.hostname==w.example.com" \
DEPLOY_NODE_DB="node.hostname==w.example.com" \
docker stack deploy -c docker-compose.yml myssh
