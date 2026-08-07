-- all_full_text_search
DROP FUNCTION IF EXISTS knowledge.all_full_text_search(pattern VARCHAR);

CREATE OR REPLACE FUNCTION knowledge.all_full_text_search(pattern VARCHAR)
    RETURNS TABLE
            (
                id           int8,
                question     text,
                short_answer text,
                project_name varchar(1024),
                project_id   int8
            )
AS
$$
BEGIN
    pattern := knowledge.replace_whitespaces_and_get_first(pattern);
    -- Perform a full-text search
    RETURN QUERY SELECT qft.id, qft.question, qft.short_answer, qft.project_name, qft.project_id
                 from knowledge.question_full_text_search(pattern) as qft
                 UNION DISTINCT
                 SELECT aft.id, aft.question, aft.short_answer, aft.project_name, aft.project_id
                 from knowledge.answer_full_text_search(pattern) as aft;

END;
$$ LANGUAGE plpgsql;