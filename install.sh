#!/bin/bash
set -xe

CURRENT_DIR="$(pwd)"
: ${OSH_INFRA_PATH:="../openstack-helm-infra"}
cd ${OSH_INFRA_PATH}
make dev-deploy setup-host
make dev-deploy k8s
cd ${CURRENT_DIR}
