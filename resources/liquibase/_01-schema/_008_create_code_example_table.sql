CREATE TABLE IF NOT EXISTS knowledge.code_example
(
    id                  bigserial PRIMARY KEY,

    question_id         bigint NOT NULL,

    language            varchar(32) NOT NULL,

    source_code         text NOT NULL,

    created_by          varchar(256) NOT NULL,
    created_date        timestamptz NOT NULL,
    updated_by          varchar(256),
    modified_date       timestamptz,

    CONSTRAINT fk_code_question
        FOREIGN KEY(question_id)
            REFERENCES knowledge.question(id)
);