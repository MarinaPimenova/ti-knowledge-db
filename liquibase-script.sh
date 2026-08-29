#!/usr/bin/env bash

# /mnt/c/Users/MarinaPimenova/sb-projects

set -ex

##echo "contextEnv: ${contextEnv}"
##DB_ADDRESS=jdbc:postgresql://localhost:5432/knowledge_db
# url=jdbc:postgresql://host.docker.internal:5432/knowledge_db
# DB_ADDRESS=172.25.9.62
DB_PASSWORD=qwerty
DB_username=knowledge_user

export PGPASSWORD="${DB_PASSWORD}"
# psql -h ${DB_ADDRESS} -U ${DB_username} -d knowledge_db -tc "CREATE SCHEMA IF NOT EXISTS knowledge AUTHORIZATION knowledge_user;"
 docker run --rm \
 --network knowledge-network \
 -v ./resources/liquibase:/liquibase/changelog \
 liquibase-pg:latest \
 --url=jdbc:postgresql://ti-knowledge-db:5432/knowledge_db \
 --username=knowledge_user \
 --password=qwerty \
 --changeLogFile=liquibase-changelog.xml \
 --contexts=dev \
 update