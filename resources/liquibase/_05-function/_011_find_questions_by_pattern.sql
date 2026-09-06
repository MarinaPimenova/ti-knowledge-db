-- find_questions_by_pattern
DROP FUNCTION IF EXISTS knowledge.find_questions_by_pattern(pattern VARCHAR);

CREATE OR REPLACE FUNCTION knowledge.find_questions_by_pattern(pattern VARCHAR)
    RETURNS TABLE
            (
                id          int8,
                tags        varchar,
                question    text,
                shortAnswer text,
                resources   varchar,
                projectName varchar(1024),
                createdby varchar
            )
AS
$$
BEGIN

    RETURN QUERY
        with questions_by_pattern(question_id)
                 as (select id as question_id
                     from knowledge.all_full_text_search(pattern))
        select qdp.id::int8,
               qdp.tags::varchar,
               qdp.question::varchar,
               qdp.shortAnswer::varchar,
               qdp.resources::varchar,
               qdp.projectName::varchar,
               qdp.createdby::varchar
        from knowledge.question_dashboard_projection qdp
                 inner join questions_by_pattern qbp on qbp.question_id = qdp.id;
END;
$$ LANGUAGE plpgsql;