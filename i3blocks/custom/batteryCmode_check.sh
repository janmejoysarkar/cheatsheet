#!/bin/bash

var="$(cat /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode)"

if [[ $var -eq 0 ]]
then
	echo '🔋'
elif [[ $var -eq 1 ]]
then
	echo '🍀'
fi
