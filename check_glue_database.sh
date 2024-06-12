#!/bin/bash

# Function to check if a Glue database exists in the current profile
check_database_in_profile() {
  PROFILE=$1
  DATABASE_NAME=$2

  echo "Checking profile: $PROFILE"
  export AWS_PROFILE=$PROFILE

  # Get caller identity to verify the AWS account
  ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
  echo "Account ID: $ACCOUNT_ID"

  # List Glue databases and check if the specified database exists
  DATABASES=$(aws glue get-databases --query "DatabaseList[].Name" --output text)

  if echo "$DATABASES" | grep -q "$DATABASE_NAME"; then
    echo "Database '$DATABASE_NAME' found in account ID $ACCOUNT_ID with profile $PROFILE."
  else
    echo "Database '$DATABASE_NAME' not found in account ID $ACCOUNT_ID with profile $PROFILE."
  fi

  echo "-----------------------------------------"
}

# Get list of all profiles
PROFILES=$(aws configure list-profiles)
DATABASE_NAME="your_database_name"  # Replace with your Glue database name

# Check each profile
for PROFILE in $PROFILES; do
  check_database_in_profile $PROFILE $DATABASE_NAME
done
