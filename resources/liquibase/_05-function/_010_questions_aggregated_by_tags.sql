--
DROP FUNCTION IF EXISTS knowledge.questions_aggregated_by_tags;
--
CREATE OR REPLACE FUNCTION knowledge.questions_aggregated_by_tags()
    RETURNS TABLE
            (
                tag            varchar,
                question_count int8
            )
AS
$$
BEGIN
    RETURN QUERY
        select t.tag::varchar,
               count(qt.question_id)::int8
        from knowledge.tag t
                 inner join knowledge.question_tag qt on t.id = qt.knowledge_tag_id
        group by t.tag
        order by count(qt.question_id) desc
        limit 3;

END;
$$ LANGUAGE plpgsql;