#!/bin/bash

WD=$(dirname "$(realpath "$0")")

source "$WD/utils/check_user.sh"
#source "$WD/utils/os.sh"

LOGFILE="$WD/output.log"

echo > "$LOGFILE"

"$WD/tasks/update_packets.sh" install | tee -a $LOGFILE
"$WD/tasks/vim.sh" install | tee -a $LOGFILE
"$WD/tasks/zsh.sh" install | tee -a $LOGFILE
