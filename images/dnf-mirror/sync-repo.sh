#!/bin/bash

# Part 1 - Register to RH CDN
subscription-manager register --username="$RHSM_USERNAME" --password="$RHSM_PASSWORD" --auto-attach

# Part 2 - Sync repo
reposync -p /workdir --download-metadata --repoid="$REPO"
