DO
$$
    BEGIN
        if not exists(select 1
                      from pg_type
                      where typname = 'question_type'
                        and typnamespace = (select oid from pg_namespace where nspname = 'knowledge')) then create type knowledge.question_type as
        (
            level_code   varchar(255),
            tag          varchar(255),
            question     text,
            short_answer text,
            resource_url varchar(1024),
            description  text,
            language     varchar(255),
            source_code  text
        );
        end if;
    END;
$$;