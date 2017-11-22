#!/bin/bash -l

syndesis-cli --cookie $SYNDESIS_COOKIE \
    -XDELETE \
    $SYNDESIS_URL/api/v1/integrations/TW2TODO-1 \
        | jq