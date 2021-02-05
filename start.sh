#!/bin/bash

WD=$(dirname "$(realpath "$0")")
TASK_DIR="$WD/script"

source "$TASK_DIR/utils/check_user.sh"
#source "$$TASK_DIR/utils/os.sh"

LOGFILE="$WD/output.log"

echo > "$LOGFILE"

"$TASK_DIR/tasks/upgrade_packets.sh" install 2>&1 | tee -a $LOGFILE
"$TASK_DIR/tasks/vim.sh" install 2>&1 | tee -a $LOGFILE
"$TASK_DIR/tasks/zsh.sh" install 2>&1 | tee -a $LOGFILE

