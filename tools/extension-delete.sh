#!/bin/bash -l

echo ""
for id in "$@"
do
    echo "Deleting extension $1"
    syndesis-cli --cookie $SYNDESIS_COOKIE -XDELETE $SYNDESIS_URL/api/v1beta1/extensions/$id | jq 
done

echo ""
echo "Extensions:"
./tools/extension-list.sh