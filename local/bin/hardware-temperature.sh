#!/bin/sh

TEMP=`acpi -t | cut -d " "  -f 4,6`
MSG=`acpi -t | cut -d " "  -f 3 | head -c-2`

echo "$TEMP, $MSG"
