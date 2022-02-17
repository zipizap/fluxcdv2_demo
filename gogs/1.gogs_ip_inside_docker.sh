docker network inspect kind | jq -r '.[0].Containers[] | select(.Name=="gogs") | .IPv4Address' | cut -d'/' -f1

