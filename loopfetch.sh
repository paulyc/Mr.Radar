#!/bin/bash -x

STA=${1:-ttpa}
ACTION=${2:-}

while true; do
	./fetch_tdwr.sh $ACTION $STA
	sleep 90
done
