#!/bin/bash

SCREENSHOT_DIR="$HOME/Screenshot"

help_func(){
    echo "
    Available options:

    -f      output to file
    -c      output to clipboard

    -s      full screen
    -w      active window
    -a      area selection

    -h      display this information

    Screenshot will be saved in $SCREENSHOT_DIR"
}


if ! [ -d "$SCREENSHOT_DIR" ]; then
    mkdir -p "$SCREENSHOT_DIR"
fi

QUALITY="8"
SCREEN_CMD=""
CLIP_CMD=""
OUTPUT_CMD=""
OUTPUT_FILE=""
NOTIFY_TITLE=""
NOTIFY_MSG=""

while getopts "fcswah" options; do
    case "${options}" in

        f)
            OUTPUT_CMD="tee"
            ;;
        c)
            CLIP_CMD="xclip -selection clipboard -t image/png -i"
            ;;
        s)
            SCREEN_CMD="maim -B --quality $QUALITY"
            OUTPUT_FILE="$SCREENSHOT_DIR/$(date +'%Y-%m-%d_%H-%M-%S')_screen.png"
            NOTIFY_TITLE="Screenshot done!"
            ;;
        w)
            SCREEN_CMD="maim -B --quality $QUALITY -i $(xdotool getactivewindow)"
            OUTPUT_FILE="$SCREENSHOT_DIR/$(date +'%Y-%m-%d_%H-%M-%S')_window.png"
            NOTIFY_TITLE="Screenshot of active window done!"
            ;;
        a)
            SCREEN_CMD="maim -B --quality $QUALITY -s -u"
            OUTPUT_FILE="$SCREENSHOT_DIR/$(date +'%Y-%m-%d_%H-%M-%S')_selection.png"
            NOTIFY_TITLE="Screenshot of selection done!"
            ;;

        h)
            help_func
            exit 2
            ;;
        *)
            help_func
            exit 2
            ;;
    esac
done



if [ -z "$SCREEN_CMD" ]
then
    help_func
    exit 2
fi

if [ -z "$OUTPUT_CMD" ] && [ -z "$CLIP_CMD" ]
then
    help_func
    exit 2
fi

if [ -n "$SCREEN_CMD" ] && [ -n "$OUTPUT_CMD" ] && [ -n "$CLIP_CMD" ]
then
    echo "to file"
    echo "to clipboard"
    $SCREEN_CMD | $OUTPUT_CMD $OUTPUT_FILE | $CLIP_CMD > /dev/null
    NOTIFY_MSG="Copied to clipboard\nSaved in $SCREENSHOT_DIR"
    notify-send "$NOTIFY_TITLE" "$NOTIFY_MSG" -u low
    exit 0
fi

if [ -n "$SCREEN_CMD" ] && [ -n "$OUTPUT_CMD" ]
then
    echo "to file"
    $SCREEN_CMD | $OUTPUT_CMD $OUTPUT_FILE > /dev/null
    NOTIFY_MSG="Saved in $SCREENSHOT_DIR"
    notify-send "$NOTIFY_TITLE" "$NOTIFY_MSG" -u low
    exit 0
fi

if [ -n "$SCREEN_CMD" ] && [ -n "$CLIP_CMD" ]
then
    echo "to clipboard"
    $SCREEN_CMD | $CLIP_CMD > /dev/null
    NOTIFY_MSG="Copied to clipboard"
    notify-send "$NOTIFY_TITLE" "$NOTIFY_MSG" -u low
    exit 0
fi


