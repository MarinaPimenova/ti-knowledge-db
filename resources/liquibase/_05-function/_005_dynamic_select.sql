
DROP FUNCTION IF EXISTS knowledge.dynamic_full_text_search;
--
CREATE OR REPLACE FUNCTION knowledge.dynamic_full_text_search(entity VARCHAR, pattern VARCHAR)
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
    input_value   text := 'SELECT id, question, short_answer as shortAnswer, project_name as projectName, project_id as projectId from knowledge.{ENTITY}_full_text_search({PATTERN})';
-- Construct the dynamic SQL statement
    DECLARE
    dynamic_sql_1 text;
    dynamic_sql_2 text;
BEGIN
    dynamic_sql_1 := REPLACE(input_value, '{ENTITY}', entity);
    dynamic_sql_2 := REPLACE(dynamic_sql_1, '{PATTERN}', quote_literal(pattern));

    RETURN QUERY EXECUTE lower(dynamic_sql_2);
END;
$$ LANGUAGE plpgsql;