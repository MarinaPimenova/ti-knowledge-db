DO
$$
    BEGIN
        if not exists(select 1
                      from pg_type
                      where typname = 'filter_params_type'
                        and typnamespace = (select oid
                                            from pg_namespace
                                            where nspname = 'knowledge')) then
            create type knowledge.filter_params_type as
            (
                projects     varchar(255),
                difficulties varchar(255),
                tags         varchar(255),
                createdBy    varchar(255)
            );
        end if;
    END;
$$;