#!/bin/sh

ACPI_TEMP=`acpi -t | cut -d " "  -f 4`
HDD_TEMP=`sensors | grep Physical | tr -s ' ' | cut -d ' ' -f 4 | cut -c 2-`
FAN=`sensors | grep fan | tr -s ' ' | cut -d ' ' -f 2`

echo "$HDD_TEMP | $ACPI_TEMP°C | $FAN RPM"
