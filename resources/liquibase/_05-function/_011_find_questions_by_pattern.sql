-- find_questions_by_pattern
DROP FUNCTION IF EXISTS knowledge.find_questions_by_pattern(pattern VARCHAR);

CREATE OR REPLACE FUNCTION knowledge.find_questions_by_pattern(pattern character varying)
    RETURNS TABLE(
                     question_id bigint,
                     tags character varying,
                     question text,
                     shortanswer text,
                     resources character varying,
                     projectname character varying,
                     createdby character varying
                 )
    LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
        WITH questions_by_pattern(q_id) AS (
            SELECT fts.id
            FROM knowledge.all_full_text_search(pattern) AS fts
        )
        SELECT qdp.id::int8 as question_id,
               qdp.tags::varchar,
               qdp.question::text,
               qdp.shortAnswer::text,
               qdp.resources::varchar,
               qdp.projectName::varchar,
               qdp.createdby::varchar
        FROM knowledge.question_dashboard_projection qdp
                 INNER JOIN questions_by_pattern qbp ON qbp.q_id = qdp.id;
END;
$$;

ALTER FUNCTION knowledge.find_questions_by_pattern(varchar) OWNER TO knowledge_user;