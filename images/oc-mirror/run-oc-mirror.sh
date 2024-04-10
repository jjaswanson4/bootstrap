#!/bin/bash

# Part 1 - Get oc-mirror command
curl https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/latest/oc-mirror.tar.gz -o oc-mirror.tar.gz
tar -xzvf oc-mirror.tar.gz
chmod +x oc-mirror

# Part 2 - Run mirror
./oc-mirror --config=/tmp/imagesetconfiguration.yaml docker://registry."$NAMESPACE".svc.cluster.local:5000 --dest-use-http=true
