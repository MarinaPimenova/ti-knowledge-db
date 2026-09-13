--
DROP FUNCTION IF EXISTS knowledge.check_array_null_values;
--
CREATE OR REPLACE FUNCTION knowledge.check_array_null_values(val varchar)
  RETURNS int[]
AS
$$
BEGIN
  if val is null then
    return null;
  else
/*    if array_length(val, 1) = 1 and array_position(val, NULL) = 1 then
        return null;
    end if;*/
    return (string_to_array(val, ','))::int[];
  end if;
END;
$$ LANGUAGE plpgsql;