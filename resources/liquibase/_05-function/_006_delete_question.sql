
DROP FUNCTION knowledge.delete_question;

CREATE OR REPLACE FUNCTION knowledge.delete_question(
    p_question_id BIGINT
)
    RETURNS void
    LANGUAGE plpgsql
AS
$$
BEGIN
    -- Check that the question exists
    IF NOT EXISTS (
        SELECT 1
        FROM knowledge.question q
        WHERE q.id = p_question_id
    ) THEN
        RAISE EXCEPTION 'Question with id % does not exist.', p_question_id;
    END IF;

    -- Delete relationships
    DELETE FROM knowledge.question_tag
    WHERE question_id = p_question_id;

    DELETE FROM knowledge.question_resource
    WHERE question_id = p_question_id;

    DELETE FROM knowledge.question_code_example
    WHERE question_id = p_question_id;

    DELETE FROM knowledge.project_question
    WHERE question_id = p_question_id;

    -- Delete the question
    DELETE FROM knowledge.question
    WHERE id = p_question_id;
END;
$$;
