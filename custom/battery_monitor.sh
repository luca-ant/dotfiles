#!/bin/bash

battery_level=`acpi -b | cut -d ' ' -f 4 | grep -o '[0-9]*'`
battery_state=$(acpi | grep 'Battery' | sed 's/Battery\s[0-9]*: //' | sed 's/, [0-9][0-9]*\%.*//')
battery_remaining=$(acpi | grep -oh '[0-9:]* remaining' | sed 's/ remaining$/s/'  | sed 's/:/h /' | sed 's/:/m /')

if [ ! -f "/tmp/.battery" ]; then
    echo "$battery_level" > /tmp/.battery
    echo "$battery_state" >> /tmp/.battery
    exit
fi

previous_battery_level=$(cat /tmp/.battery | head -n 1)
previous_battery_state=$(cat /tmp/.battery | tail -n 1)
echo "$battery_level" > /tmp/.battery
echo "$battery_state" >> /tmp/.battery

checkBatteryLevel() {

    if [ "$battery_state" != "Discharging" ] || [ "${battery_level}" == "${previous_battery_level}" ]; then
        exit
        notify-send "Battery (${battery_level}%)" -u low -t 10000
    fi

    if [ $battery_level -le 7 ]; then
        notify-send "Battery discharged (${battery_level}%)" "${battery_remaining} of battery remaining.\nPlease, plug into a power source!" -u critical -t 30000
#        notify-send "Battery discharged (${battery_level}%)" "${battery_remaining} of battery remaining.\nYour computer will suspend in 30 seconds!" -u critical -t 30000
#        sleep 30 && systemctl suspend

    elif [ $battery_level -le 10 ]; then
        notify-send "Very Low Battery (${battery_level}%)" "${battery_remaining} of battery remaining.\nPlease, plug into a power source!" -u critical -t 30000
#        notify-send "Very Low Battery (${battery_level}%)" "${battery_remaining} of battery remaining.\nYour computer will suspend soon unless plugged into a power source!" -u critical -t 30000

    elif [ $battery_level -le 15 ]; then
        notify-send "Low Battery (${battery_level}%)" "${battery_remaining} of battery remaining." -u normal -t 30000
    fi
}

checkBatteryStateChange() {

    if [ "$battery_state" == "Full" ] && [ "$previous_battery_state" == "Charging" ]; then
        notify-send "Battery Charged" -u low -t 10000
    fi

    if [ "$battery_state" == "Charging" ] && [ "$previous_battery_state" == "Discharging" ]; then
        notify-send "Charging" "Battery is now plugged in." -u low -t 10000
    fi

#    if [ "$battery_state" == "Charging" ] && [ "$previous_battery_state" != "Charging" ]; then
#        notify-send "Charging" "Battery is now plugged in." -u low -t 10000
#    fi

    if [ "$battery_state" == "Discharging" ] && [ "$previous_battery_state" == "Charging" ]; then
        notify-send "Power Unplugged" "Your computer has been disconnected from power." -u low -t 10000
    fi
    if [ "$battery_state" == "Discharging" ] && [ "$previous_battery_state" == "Full" ]; then
        notify-send "Power Unplugged" "Your computer has been disconnected from power." -u low -t 10000
    fi
}

checkBatteryStateChange
checkBatteryLevel

exit 0



