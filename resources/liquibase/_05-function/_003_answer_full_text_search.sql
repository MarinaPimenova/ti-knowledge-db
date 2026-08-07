-- _003_answer_full_text_search.sql
DROP FUNCTION IF EXISTS knowledge.answer_full_text_search;
-- Question
CREATE OR REPLACE FUNCTION knowledge.answer_full_text_search(pattern VARCHAR)
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
DECLARE
    resource_type_var VARCHAR(256);
BEGIN
    resource_type_var := 'Answer';
    pattern := knowledge.replace_whitespaces_and_get_first(pattern);
    -- Perform a full-text search
    RETURN QUERY SELECT DISTINCT q.id, q.question, q.short_answer, p.project_name, pq.project_id
                 FROM knowledge.question q
                          left join knowledge.project_question pq on q.id = pq.question_id
                          left join knowledge.project p on pq.project_id = p.id
                 WHERE to_tsvector('english', COALESCE(q.short_answer, '')) @@ plainto_tsquery('english', pattern);
END;
$$ LANGUAGE plpgsql;