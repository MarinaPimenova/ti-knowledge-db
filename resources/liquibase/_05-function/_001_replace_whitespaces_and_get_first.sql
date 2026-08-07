
DROP FUNCTION IF EXISTS knowledge.replace_whitespaces_and_get_first CASCADE;

--
CREATE OR REPLACE FUNCTION knowledge.replace_whitespaces_and_get_first(input_param VARCHAR)
    RETURNS VARCHAR
    LANGUAGE plpgsql
AS
$$
DECLARE
    output_var VARCHAR;
BEGIN
    output_var := COALESCE(input_param, '');
    output_var := regexp_replace(output_var, '\s+', ' ', 'g');
    output_var := split_part(output_var, ' ', 1);
    RETURN output_var;
END;
$$;