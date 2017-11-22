#!/bin/bash -l

syndesis-cli --cookie $SYNDESIS_COOKIE \
    -H "Content-Type: application/json" \
    -XPUT \
    $SYNDESIS_URL/api/v1/integrations/TW2TODO-1 \
    -d @samples/TW2TODO.json \
        | jq