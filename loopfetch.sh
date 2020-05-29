#!/bin/bash -x

STA=${1:-ttpa}

while true; do
	./fetch_tdwr.sh $STA
	sleep 90
done
