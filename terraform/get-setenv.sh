#!/bin/sh
# BASH_SOURCE="-bash"
# if [ "$0" == "$BASH_SOURCE" ]; then
#   echo "$0: Please source this file."
#   echo "e.g. source ./get-setenv.sh configurations/data-rnd-us-vet1-v1"
#   return 1
# fi

# Get directory we are running from
DIR=$(pwd)
DATAFILE="$DIR/$1"

# if [ ! -d "$DIR/configurations" ]; then
#     echo "setenv: Must be run from the root directory of the terraform project."
#     return 1
# fi

if [ ! -f "$DATAFILE" ]; then
    echo "setenv: Configuration file not found: $DATAFILE"
    return 1
fi

# Get env from DATAFILE
#ENVIRONMENT=$(sed -nE 's/^\s*environment\s*=\s*"([^"]*)".*$/\1/p' "$DATAFILE")
#S3BUCKET=$(sed -nE 's/^\s*s3_bucket\s*=\s*"([^"]*)".*$/\1/p' "$DATAFILE")
#S3FOLDERPROJ=$(sed -nE 's/^\s*s3_folder_project\s*=\s*"([^"]*)".*$/\1/p' "$DATAFILE")
#S3BUCKETREGION=$(sed -nE 's/^\s*s3_bucket_region\s*=\s*"([^"]*)".*$/\1/p' "$DATAFILE")
#AWSDEPLOYREGION=$(sed -nE 's/^\s*aws_region\s*=\s*"([^"]*)".*$/\1/p' "$DATAFILE")
#S3TFSTATEFILE=$(sed -nE 's/^\s*s3_tfstate_file\s*=\s*"([^"]*)".*$/\1/p' "$DATAFILE")

ENVIRONMENT=$(grep environment "$DATAFILE" | awk -F '=' '{print $2}' | sed -e 's/["\ ]//g')
S3BUCKET=$(grep s3_bucket\  "$DATAFILE" | awk -F '=' '{print $2}' | sed -e 's/["\ ]//g')
S3FOLDERPROJ=$(grep s3_folder_project "$DATAFILE" | awk -F '=' '{print $2}' | sed -e 's/["\ ]//g')
S3BUCKETREGION=$(grep s3_bucket_region "$DATAFILE" | awk -F '=' '{print $2}' | sed -e 's/["\ ]//g')
AWSDEPLOYREGION=$(grep aws_region "$DATAFILE" | awk -F '=' '{print $2}' | sed -e 's/["\ ]//g')
S3TFSTATEFILE=$(grep s3_tfstate_file "$DATAFILE" | awk -F '=' '{print $2}' | sed -e 's/["\ ]//g')

if [ -z "$ENVIRONMENT" ]
then
    echo "setenv: 'environment' variable not set in configuration file."
    return 1
fi
if [ -z "$S3BUCKET" ]
then
    echo "setenv: 's3_bucket' variable not set in configuration file."
    return 1
fi
if [ -z "$S3FOLDERPROJ" ]
then
    S3FOLDERPROJ=$(sed -nr 's/^\s*project_name\s*=\s*"([^"]*)".*$/\1/p' "$DATAFILE")
    if [ -z "$S3FOLDERPROJ" ]
    then
        echo "setenv: 's3_folder_project' variable not set in configuration file."
        return 1
    fi
fi
if [ -z "$S3BUCKETREGION" ]
then
    echo "setenv: 's3_bucket_region' variable not set in configuration file."
    return 1
fi
if [ -z "$AWSDEPLOYREGION" ]
then
    echo "setenv: 'aws_region' variable not set in configuration file."
    return 1
fi
if [ -z "$S3TFSTATEFILE" ]
then
    echo "setenv: 's3_tfstate_file' variable not set in configuration file."
    echo "e.g. s3_tfstate_file=\"infrastructure.tfstate\""
    return 1
fi

# if [ "$ENVIRONMENT" = "feature" ]
# then
#     ENVIRONMENT="dev"
# elif [ "$ENVIRONMENT" = "pr" ]
# then
#     ENVIRONMENT="dev"
# fi
# cat << EOF > $DIR/backend.tf
# terraform {
#   backend "s3"{
#   bucket="${S3BUCKET}"
#   key= "${S3FOLDERPROJ}/${AWSDEPLOYREGION}/${ENVIRONMENT}/${S3TFSTATEFILE}"
#   region ="${S3BUCKETREGION}"
#   dynamodb_table = "${S3BUCKET}"
#   encrypt = true
# }
# }
# EOF

# Verify if user has valid AWS credentials in current session
#if CALLER_IDENTITY=$(aws sts get-caller-identity 2>&1); then
#    echo "Using AWS Identity: ${CALLER_IDENTITY}"
#else
#    echo "setenv: Please run 'get-temporary-aws-credentials.sh' first"
#    return 1
#fi

export DATAFILE
export TF_WARN_OUTPUT_ERRORS=1
rm -rf "$DIR/.terraform"

cd "$DIR"

echo "setenv: Initializing terraform"
terraform init > /dev/null
