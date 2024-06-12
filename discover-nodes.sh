#!/bin/bash

# scans network and generates targets.json file for prometheus files_sd_configs

# port and network to scan
TARGET_PORT=9100
TARGET_NETWORK=10.0.20.0/24

# get list of hosts running prometheus node exporter using nmap
TARGETS=()
while IFS= read -r line; do
    TARGETS+=( "$line" )
done < <( nmap -Pn -oG - -p $TARGET_PORT $TARGET_NETWORK | grep "$TARGET_PORT"'/open' | awk '{print substr($3, 2, length($3) - 2)}' )


# convert targets to json format
PADDING="      " # 6 space padding
TARGETS_JSON=$(printf "$PADDING\"%s:$TARGET_PORT\",\n" "${TARGETS[@]}")

# the json output; removes padding from first line and trailing comma from last line
JSON='[
  {
    "labels": {
      "job": "node_exporter"
    },
    "targets": [
      '"${TARGETS_JSON:6:-1}"'
    ]
  }
]'

echo "$JSON"
