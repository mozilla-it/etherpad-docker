#!/bin/bash
set -euxo pipefail
min_stamp=$(date -d "-15 days" +%s)

count=0

for p in $(curl -s --data-urlencode "apikey=$ETHERPAD_API_KEY" "http://localhost:$PORT/api/1.2.1/listAllPads" | jq .data.padIDs[] | xargs echo); do 
	last_updated=$(curl -s --data-urlencode "padID=$p" --data-urlencode "apikey=$ETHERPAD_API_KEY" "http://localhost:$PORT/api/1/getLastEdited" | jq '.data.lastEdited')
	((last_stamp=last_updated/1000))
	if [[ $last_stamp -lt $min_stamp ]]; then
		echo $p is old and will be deleted
		curl -s \
			--data-urlencode "apikey=$ETHERPAD_API_KEY" \
			--data-urlencode "padID=$p" \
			"http://localhost:$PORT/api/1/deletePad"
		((count++))
	fi
done

echo "Identified and deleted $count pads"
