#!/bin/bash

# Part 1 - Get oc-mirror command
curl https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/latest/oc-mirror.tar.gz -o oc-mirror.tar.gz
tar -xzvf oc-mirror.tar.gz
chmod +x oc-mirror

# Part 2 - Decode base64 pull secret if needed

# Part 2 - Run mirror
./oc-mirror --config=/tmp/imagesetconfiguration.yaml docker://"$REGISTRY" --dest-use-http=$DEST_USE_HTTP --dest-skip-tls=$DEST_SKIP_TLS
