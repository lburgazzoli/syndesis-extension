#!/bin/bash -l

ID=$(\
    syndesis-cli --cookie $SYNDESIS_COOKIE -XGET $SYNDESIS_URL/api/v1beta1/extensions \
        | jq \
            --raw-output \
            '.items[] | select(.status == "Installed" and .extensionId == "com.github.lburgazzoli:syndesis-extensions") | .id'\
)


if [ -z $ID ]; then
    echo "Extension does not exists, create it"
    
    ID=$(\
        syndesis-cli --cookie $SYNDESIS_COOKIE \
        -XPOST \
        -F body=@./target/syndesis-extensions-1.0.0-SNAPSHOT.jar \
        $SYNDESIS_URL/api/v1beta1/extensions \
            | jq --raw-output '.id' \
    )

    echo "Extension id: $ID"
    echo "Validate"
    
    syndesis-cli --cookie $SYNDESIS_COOKIE \
        -XPOST \
        "$SYNDESIS_URL/api/v1beta1/extensions/$ID/validation" \
            | jq --raw-output

    echo "Install"
    
    syndesis-cli --cookie $SYNDESIS_COOKIE \
        -XPOST \
        "$SYNDESIS_URL/api/v1beta1/extensions/$ID/install" \
            | jq --raw-output
else
    echo "Extension already exists with id: $ID, update it"

    ID=$(\
        syndesis-cli --cookie $SYNDESIS_COOKIE \
        -XPOST \
        -F body=@./target/syndesis-extensions-1.0.0-SNAPSHOT.jar \
        "$SYNDESIS_URL/api/v1beta1/extensions?updatedId=$ID" \
            | jq --raw-output '.id' \
    )

    echo "New id: $ID"
    echo "Validate"
    
    syndesis-cli --cookie $SYNDESIS_COOKIE \
        -v \
        -XPOST \
        "$SYNDESIS_URL/api/v1beta1/extensions/$ID/validation" \
            | jq --raw-output

    echo "Install"
    
    syndesis-cli --cookie $SYNDESIS_COOKIE \
        -XPOST \
        "$SYNDESIS_URL/api/v1beta1/extensions/$ID/install" \
            | jq --raw-output
fi



echo ""
echo "Extensions:"
./tools/extension-list.sh