## Create Liquibase image with Postgre driver
Run the following to create image based on Dockerfile:

docker build -t liquibase-pg .

## Find IP address
ip addr output, your primary host IP 
(the one your computer uses to talk to the network) 
is on the eth0 interface.

## run the docker command from the project/ directory.

project/

├── resources/
│   └── liquibase/
│       └── liquibase-changelog.xml  <-- The file is here

The result should be:

Starting Liquibase at 20:39:28 using Java 21.0.8 (version 5.0.0 #9369 built at 2025-09-29 17:12+0000)
Liquibase Version: 5.0.0

Running Changeset: liquibase-changelog.xml::1::pm
schema "assistant_eval" already exists, skipping
Running Changeset: liquibase-changelog.xml::2::pm
relation "chat_id_seq" already exists, skipping
Running Changeset: liquibase-changelog.xml::3::pm
relation "question_id_seq" already exists, skipping
Running Changeset: liquibase-changelog.xml::4::pm
relation "confluence_agent_id_seq" already exists, skipping
Running Changeset: liquibase-changelog.xml::5::pm
relation "nlp2sql_agent_id_seq" already exists, skipping
Running Changeset: liquibase-changelog.xml::6::pm
relation "sharepoint_agent_id_seq" already exists, skipping
Running Changeset: liquibase-changelog.xml::7::pm
relation "aw_attachment_agent_id_seq" already exists, skipping
Running Changeset: liquibase-changelog.xml::8::pm
Running Changeset: liquibase-changelog.xml::9::pm
Running Changeset: liquibase-changelog.xml::10::pm
relation "evaluator_report_id_seq" already exists, skipping
Running Changeset: liquibase-changelog.xml::11::pm
relation "evaluator_report_result_id_seq" already exists, skipping
Running Changeset: liquibase-changelog.xml::12::pm
Running Changeset: liquibase-changelog.xml::13::pm
Running Changeset: liquibase-changelog.xml::14::pm
Running Changeset: liquibase-changelog.xml::15::pm
