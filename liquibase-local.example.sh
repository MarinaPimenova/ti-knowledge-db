#!/usr/bin/env bash

set -ex

# Set variables from environment if provided, otherwise fall back to defaults
DB_ADDRESS="${DB_ADDRESS:-ti-knowledge-db:5432}"
DB_PASSWORD="${DB_PASSWORD:-qwerty}"
DB_USERNAME="${DB_USERNAME:-knowledge_user}"

docker run --rm \
  --network knowledge-network \
  -v ./resources/liquibase:/liquibase/changelog \
  mnpma/liquibase-pg:5.0 \
  --url=jdbc:postgresql://${DB_ADDRESS}/knowledge_db \
  --username=${DB_USERNAME} \
  --password=${DB_PASSWORD} \
  --changeLogFile=liquibase-changelog.xml \
  --contexts=dev \
  update

# or one more possible case to run:
CONTAINER_NAME=
NETWORK=knowledge-network
 docker run --rm \
 --network ${NETWORK} \
 -v ./resources/liquibase:/liquibase/changelog \
 liquibase-pg:latest \
 --url=jdbc:postgresql://${CONTAINER_NAME}:5432/knowledge_db \
  --username=${DB_username} \
  --password=${DB_PASSWORD} \
 --changeLogFile=liquibase-changelog.xml \
 --contexts=dev \
 update