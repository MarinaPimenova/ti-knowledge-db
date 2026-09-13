# Knowledge Database

## Table of Contents

<!-- toc -->

- [Introduction](#introduction)
- [Database Purpose](#database-purpose)
- [Repository Structure](#repository-structure)
- [Database Migration Strategy](#database-migration-strategy)
- [Requirements](#requirements)
- [Run PostgreSQL Locally](#run-postgresql-locally)
- [Apply Liquibase Changes](#apply-liquibase-changes)
- [Liquibase Contexts](#liquibase-contexts)

<!-- tocstop -->


# Introduction

The **Knowledge Database** repository contains database schema definitions and migration scripts for the Internal Knowledge Platform.

The database stores:

- Interview questions
- Short and detailed answers
- Knowledge categories
- Knowledge tags
- Learning resources
- Code examples
- Project associations


# Database Purpose

The database follows the following principles:

- PostgreSQL database
- Liquibase based database versioning
- Immutable migration scripts
- Database-first schema management
- Audit fields on all business tables


All tables contain audit information:

```text
created_by
created_date
updated_by
modified_date
```

```mermaid
erDiagram

    PROJECT {
        bigint id PK
        varchar project_name
        varchar project_lead
        varchar created_by
        timestamptz created_date
        varchar updated_by
        timestamptz modified_date
    }

    QUESTION_LEVEL {
        bigint id PK
        varchar code
        varchar description
        varchar created_by
        timestamptz created_date
        varchar updated_by
        timestamptz modified_date
    }

    KNOWLEDGE_CATEGORY {
        bigint id PK
        varchar category
        varchar description
        varchar created_by
        timestamptz created_date
        varchar updated_by
        timestamptz modified_date
    }

    KNOWLEDGE_TAG {
        bigint id PK
        bigint knowledge_category_id FK
        varchar tag
        varchar description
        varchar created_by
        timestamptz created_date
        varchar updated_by
        timestamptz modified_date
    }

    QUESTION {
        bigint id PK
        bigint question_level_id FK
        text question
        text short_answer
        text detailed_answer
        varchar created_by
        timestamptz created_date
        varchar updated_by
        timestamptz modified_date
    }

    RESOURCE {
        bigint id PK
        varchar description
        varchar resource_url
        varchar created_by
        timestamptz created_date
        varchar updated_by
        timestamptz modified_date
    }

    CODE_EXAMPLE {
        bigint id PK
        varchar language
        text source_code
        varchar created_by
        timestamptz created_date
        varchar updated_by
        timestamptz modified_date
    }

    QUESTION_TAG {
        bigint id PK
        bigint question_id FK
        bigint knowledge_tag_id FK
        varchar created_by
        timestamptz created_date
        varchar updated_by
        timestamptz modified_date
    }

    QUESTION_RESOURCE {
        bigint id PK
        bigint question_id FK
        bigint resource_id FK
        varchar created_by
        timestamptz created_date
        varchar updated_by
        timestamptz modified_date
    }

    QUESTION_CODE_EXAMPLE {
        bigint id PK
        bigint question_id FK
        bigint code_example_id FK
        varchar created_by
        timestamptz created_date
        varchar updated_by
        timestamptz modified_date
    }

    PROJECT_QUESTION {
        bigint id PK
        bigint project_id FK
        bigint question_id FK
        varchar created_by
        timestamptz created_date
        varchar updated_by
        timestamptz modified_date
    }

    QUESTION_LEVEL ||--o{ QUESTION : classifies

    KNOWLEDGE_CATEGORY ||--o{ KNOWLEDGE_TAG : contains

    QUESTION ||--o{ QUESTION_TAG : tagged
    KNOWLEDGE_TAG ||--o{ QUESTION_TAG : assigned

    QUESTION ||--o{ QUESTION_RESOURCE : references
    RESOURCE ||--o{ QUESTION_RESOURCE : linked

    QUESTION ||--o{ QUESTION_CODE_EXAMPLE : illustrates
    CODE_EXAMPLE ||--o{ QUESTION_CODE_EXAMPLE : reused

    PROJECT ||--o{ PROJECT_QUESTION : contains
    QUESTION ||--o{ PROJECT_QUESTION : belongs_to
```

# Repository Structure

```
resources
└── liquibase

    ├── liquibase-changelog.xml
    ├── schema.xml
    ├── reference-data.xml
    ├── sample-data.xml
    |
    ├── _01-schema
    │   ├── _001_create_schema.sql
    │   ├── _002_create_project_table.sql
    │   └── ...
    |
    ├── _02-reference-data
    │   ├── _001_insert_question_level.sql
    │   ├── _002_insert_knowledge_category.sql
    │   └── _003_insert_knowledge_tag.sql
    |...
    ├── _05-sample-data
    │   ├── _001_insert_project.sql
    │   ├── _002_insert_question.sql
    │   └── ...
    |
    ├── liquibase.properties
    └── liquibase-dev.examples.properties


liquibase-local.sh
liquibase-local.example.sh
Dockerfile
README.md
```


# Database Migration Strategy

Liquibase changelog is divided into three areas.


## Schema

Contains database structure:

- Schema creation
- Tables
- Constraints
- Foreign keys
- Indexes


Executed in all environments.


## Reference Data

Contains mandatory application data:

Examples:

- Question levels
- Knowledge categories
- Knowledge tags


Executed in all environments.


## Sample Data

Contains demo/training data:

Examples:

- Example questions
- Code examples
- Resources


Executed only for:

- Local
- Development


# Requirements

Required:

1. Git
2. Docker
3. Docker Compose

---

# Run PostgreSQL Locally

```text
Clone repository
|
v
docker compose up
|
v
Build liquibase image
|
v
Run Liquibase migration
|
v
Database ready
```

The local development environment uses Docker Compose.

The Docker environment contains:

- PostgreSQL database
- Database initialization scripts


## Docker Structure

```
docker
│
├── docker-compose.yml
│
└── kb-scripts
    └── init.sql
```

`init.sql` is executed automatically when the PostgreSQL container is created for the first time.

It is responsible for:

- Creating database users
- Creating database
- Initial database configuration


## Start PostgreSQL Container

From the project root:

```bash
cd docker

docker compose up -d
```

Verify running containers:

```bash
docker ps
```

Expected result:

```text
postgres container is running
```


## Stop PostgreSQL Container

```bash
docker compose down
```

Remove volumes:

```bash
docker compose down --remove-orphans --volumes
```

> Removing volumes deletes the local database data.


# Apply Liquibase Changes

Liquibase migrations are executed using a custom Docker image with PostgreSQL support.


## Repository Structure

```
project-root

├── docker
│   |
│   └── liquibase-dockerfile-to-image
│       |
│       ├── Dockerfile
│       └── README.md
│
└── resources
    |
    └── liquibase
        |
        └── liquibase-changelog.xml
```


# Create Liquibase Docker Image

Navigate to the Liquibase Docker image directory:

```bash
cd docker/liquibase-dockerfile-to-image
```

Build the image:

```bash
docker build -t liquibase-pg .
```

The image contains:

- Liquibase 5.0.0
- Java 21
- PostgreSQL Liquibase extension


Verify image:

```bash
docker images
```

Expected:

```text
liquibase-pg
```


# Execute Liquibase Migration

Run the Liquibase container from the project root directory.

Example:

```bash
docker run --rm \
-v ./resources/liquibase:/liquibase/changelog \
liquibase-pg \
--url=jdbc:postgresql://<HOST_IP>:5432/knowledge_db \
--username=knowledge_user \
--password=qwerty \
--changeLogFile=liquibase-changelog.xml \
--contexts=dev \
update
```

Replace:

```text
<HOST_IP>
```

with **CONTAINER_NAME**.

## PostgreSQL Storage

PostgreSQL uses a Docker named volume:

postgres-data

This is intentional because PostgreSQL requires Linux filesystem permissions.
Using a bind mount from Windows filesystem (`/mnt/c`) may cause permission errors during database initialization.

The database scripts are mounted separately:

./docker/kb-scripts
|
v
/docker-entrypoint-initdb.d


# Successful Migration Output

Expected output:

```text
Starting Liquibase at 20:39:28 using Java 21.0.8
(version 5.0.0)

Liquibase Version: 5.0.0

Running Changeset:
liquibase-changelog.xml::1::pm

Running Changeset:
liquibase-changelog.xml::2::pm

...

Liquibase command 'update' was executed successfully.
```


# Liquibase Contexts

The project uses Liquibase contexts to control environment-specific data.


## Development Environment

Run with:

```bash
--contexts=dev
```

Executed:

- Database schema
- Reference data
- Sample data


## Production Environment

Run with:

```bash
--contexts=prod
```

Executed:

- Database schema
- Reference data

Not executed:

- Training questions
- Example resources
- Demo code examples

## Troubleshooting 

```bash
docker logs <CONTAINER_NAME>
e.g.
docker logs knowledge-postgres
```

Developer Machine (WSL2)

                Docker Network
              knowledge-network
                     |
        +------------+------------+
        |                         |
        v                         v

knowledge-postgres          liquibase-pg
(PostgreSQL 17)             (Liquibase 5)

        |
        |
        v

Docker Named Volume
postgres-data

        |
        |
        v

PostgreSQL data files
(Linux filesystem managed by Docker)

