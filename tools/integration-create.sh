#!/bin/bash -l

syndesis-cli --cookie $SYNDESIS_COOKIE \
    -H "Content-Type: application/json" \
    -XPOST \
    $SYNDESIS_URL/api/v1/integrations \
    -d @samples/TW2TODO.json \
        | jq