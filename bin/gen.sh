#!/bin/sh

if [ ! -s Templates/Router.stencil ]; then
    mkdir -p Templates
    curl -o Templates/Router.stencil https://raw.githubusercontent.com/ainame/Lumpik/master/Templates/Router.stencil
fi

PROJECT=$1
if [ "$PROJECT" == "" ]; then
    echo "Usage: bin/gen.sh Sources/XXXX"
    exit 1
fi

sourcery --sources $PROJECT --templates Templates --output $PROJECT
