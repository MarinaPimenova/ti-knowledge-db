#!/usr/bin/env bash

# /mnt/c/Users/<USER>/sb-projects

set -ex

##echo "contextEnv: ${contextEnv}"
##DB_ADDRESS=jdbc:postgresql://localhost:5432/knowledge_db
# url=jdbc:postgresql://host.docker.internal:5432/knowledge_db
DB_ADDRESS=
DB_PASSWORD=qwerty
DB_username=knowledge_user

export PGPASSWORD="${DB_PASSWORD}"
# psql -h ${DB_ADDRESS} -U ${DB_username} -d knowledge_db -tc "CREATE SCHEMA IF NOT EXISTS knowledge AUTHORIZATION knowledge_user;"
docker run --rm -v ./resources/liquibase:/liquibase/changelog \
  liquibase-pg:latest \
  --url=jdbc:postgresql://${DB_ADDRESS}:5432/knowledge_db \
  --username=${DB_username} \
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