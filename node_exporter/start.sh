#!/bin/bash

export TAILSCALE_IP=$(tailscale ip --4)

docker compose up --build -d
