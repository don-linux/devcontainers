#!/usr/bin/env bash

echo "Directory id's:"

id -u
id -g

echo "Setting permissions for the folder"

sudo chown -R $(id -u):$(id -g) .