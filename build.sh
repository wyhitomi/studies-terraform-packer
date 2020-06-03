#!/usr/bin/env bash
echo "*** Deployment started"
usage() {
  echo "environment variable access keys (ARM_CLIENT_ID, ARM_CLIENT_SECRET, ARM_SUBSCRIPTION_ID and ARM_TENANT_ID) to be set"
  exit 1
}

if [ ${#} -ne 2 ]; then
  usage
fi
ARM_CLIENT_ID=$1  
ARM_CLIENT_SECRET=$2
ARM_SUBSCRIPTION_ID=$3
ARM_TENANT_ID=$4

export SSH_KEY_NAME
SSH_KEY_NAME="mykey"
export IMAGE_NAME
IMAGE_NAME="vortx-metabase-image"
sed -i -e "s/default_image_name/${IMAGE_NAME}/g" terraform/vars.tf
echo "***  starting packer"
sh packer.sh $ARM_CLIENT_ID $ARM_CLIENT_SECRET $ARM_SUBSCRIPTION_ID $ARM_TENANT_ID;

echo "***  starting terraform" 
sh terraform.sh; 
sed -i -e "s/${IMAGE_NAME}/ami_image_name/g" terraform/vars.tf
echo "*** Deployment complete"