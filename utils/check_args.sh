#!/bin/bash


usage(){
    echo "Usage: $0 [ install | remove ]"
}
if [ $# != 1 ]
then
    usage
    exit 1
fi
if [ $1 != install ] && [ $1 != remove ]
then
    usage
    exit 2
fi
