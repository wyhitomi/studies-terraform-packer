#!/usr/bin/env bash
set -e

run_packer() {
  set -x
echo "enter into run packer"
  packer build \
 -var arm_client_id=$1\
 -var arm_client_secret=$2\
 -var arm_subscription_id=$3\
 -var arm_tenant_id=$4\
 packer/packer.json
  set +x
}

run_packer $ARM_CLIENT_ID $ARM_CLIENT_SECRET $ARM_SUBSCRIPTION_ID $ARM_TENANT_ID