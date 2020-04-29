#!/bin/bash

WD=$(dirname $(realpath $0))
WD=$(dirname "$WD")

source "$WD/utils/check_user.sh"
source "$WD/utils/os.sh"
#source "$WD/utils/check_args.sh"

usage(){
    run_command echo "Usage: $0 [ install | remove ]"
}
if [ $# != 1 ]
then
    usage
    exit 1
fi
if [ $1 != "install" ] && [ $1 != "remove" ]
then
    usage
    exit 2
fi

if [ $1 == "install" ] 

then
    update_packets


elif [ $1 == "remove" ]
then

    run_command echo "Nothing to do!"

else
    usage
    exit 3
fi


