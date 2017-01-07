#!/bin/bash

CURRENT_DIR=$(realpath .)

if [ "$(basename $CURRENT_DIR)" == "scripts" ]; then
    ROOT_PATH=$(dirname ${PWD})
else
    ROOT_PATH=${PWD}
fi

WEB_PATH=$ROOT_PATH/web
DATA_PATH=$ROOT_PATH/data
ETC_PATH=$ROOT_PATH/etc
APP_PATH=$WEB_PATH/app

rm -Rf $DATA_PATH/db/*
rm -Rf $APP_PATH/vendor
rm -Rf $APP_PATH/composer.lock

CONTAINERS=$(docker ps -aq)
docker rm -f $CONTAINERS

docker volume rm $(docker volume ls)
