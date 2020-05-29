#!/bin/bash -x

if [[ "$1" == "save" || "$1" == "plot" ]]; then
	ACTION="$1"
	shift
fi

ACTION=${ACTION:-none}
STA=${1:-ttpa}
PROD=${2:-180z0}
COUNTER=${3:-last}

#ftp://tgftp.nws.noaa.gov/SL.us008001/DF.of/DC.radar/DS.180z0/SI.txxx/sn.0yyy
URI="ftp://tgftp.nws.noaa.gov/SL.us008001/DF.of/DC.radar/DS.${PROD}/SI.${STA}/sn.${COUNTER}"
TIMESTAMP=$(date +%s)
FILENAME="data/sn.${PROD}.${STA}.${COUNTER}.${TIMESTAMP}"

echo "Station ${STA} URI ${URI}"

function fetch_latest()
{
	mkdir -p $(dirname "$FILENAME")
	curl "$URI" > "$FILENAME"
}

function plot_action()
{
	if [ "$ACTION" != "none" ]; then
		./nexrad32plot.py "$FILENAME" "$ACTION"
	fi
}

fetch_latest
plot_action


