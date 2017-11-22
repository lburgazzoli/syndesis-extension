#!/bin/bash -l

syndesis-cli --cookie $SYNDESIS_COOKIE -XGET $SYNDESIS_URL/api/v1beta1/extensions \
    | jq \
        --raw-output \
        '.items[] | select(.extensionId == "com.github.lburgazzoli:syndesis-extensions") | "  \(.id) -> \(.status)"'