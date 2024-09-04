#!/bin/bash

# Part 1 - Get oc-mirror command
curl https://developers.redhat.com/content-gateway/rest/mirror/pub/openshift-v4/clients/mirror-registry/latest/mirror-registry.tar.gz -o oc-mirror.tar.gz
tar -xzvf oc-mirror.tar.gz
chmod +x oc-mirror

# Part 2 - Run mirror
./oc-mirror --config=/tmp/imagesetconfiguration.yaml docker://registry."$NAMESPACE".svc.cluster.local:5000 --dest-use-http=true
