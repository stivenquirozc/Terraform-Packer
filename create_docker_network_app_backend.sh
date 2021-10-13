#!/usr/bin/env bash

sudo docker network create app
sudo git clone https://github.com/stivenquirozc/movie-analyst-api.git
cd movie-analyst-api
sudo docker-compose build
sudo docker-compose up -d 