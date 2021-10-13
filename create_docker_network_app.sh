#!/usr/bin/env bash

sudo docker network create app
sudo git clone https://github.com/stivenquirozc/movie-analyst-ui.git
cd movie-analyst-ui
sudo docker-compose build
sudo docker-compose up -d 
