--
DROP FUNCTION IF EXISTS knowledge.get_filtered_questions;
--
CREATE OR REPLACE FUNCTION knowledge.get_filtered_questions(
    filter knowledge.filter_params_type)
    RETURNS TABLE
            (
                id            int8,
                question      varchar,
                shortAnswer   varchar,
                projectName   varchar,
                questionLevel varchar,
                tagName       varchar
            )
AS
$$
DECLARE
    filter_project    int[];
    filter_level_code int[];
    filter_tag        int[];
    filter_created_by varchar;
BEGIN
    filter_project := knowledge.check_array_null_values((filter.projects));
    filter_level_code := knowledge.check_array_null_values((filter.difficulties));
    filter_tag := knowledge.check_array_null_values((filter.tags));
    filter_created_by := filter.createdBy;
    RETURN QUERY
        SELECT q.id::bigint,
               q.question::varchar,               -- Explicit cast fixes column 2 mismatch
               q.short_answer::varchar AS shortAnswer,
               p.project_name::varchar AS projectName,
               ql.code::varchar        AS questionLevel,
               t.tag::varchar          AS tagName
        from knowledge.question q
                 left join knowledge.question_level ql on q.question_level_id = ql.id
                 left join knowledge.question_tag qt on q.id = qt.question_id
                 left join knowledge.tag t on qt.knowledge_tag_id = t.id
                 left join knowledge.question_resource qr on q.id = qr.question_id
                 left join knowledge.resource r on qr.resource_id = r.id
                 left join knowledge.project_question pq on q.id = pq.question_id
                 left join knowledge.project p on pq.project_id = p.id
        where q.created_by = filter_created_by
          and (filter_project is null or p.id = ANY (filter_project))
          and (filter_level_code is null or ql.id = ANY (filter_level_code))
          and (filter_tag is null or t.id = ANY (filter_tag));

END;
$$ LANGUAGE plpgsql;