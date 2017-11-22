#!/bin/bash -l

syndesis-cli --cookie $SYNDESIS_COOKIE \
    -XGET \
    $SYNDESIS_URL/api/v1/integrations \
        | jq