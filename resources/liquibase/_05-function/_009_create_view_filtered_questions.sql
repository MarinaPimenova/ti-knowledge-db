--
DROP FUNCTION IF EXISTS knowledge.view_filtered_questions;
--
CREATE OR REPLACE FUNCTION knowledge.view_filtered_questions(
  filter knowledge.filter_params_type)
  RETURNS TABLE
          (
            id              int8,
            question        varchar,
            shortAnswer     varchar,
            projects        varchar,
            difficultyLevel varchar,
            tags            varchar
          )
AS
$$
BEGIN
  RETURN QUERY
    with filtered_question(id, question, shortAnswer, projectName, questionLevel, tagName)
           as (select id, question, shortAnswer, projectName, questionLevel, tagName
               from knowledge.get_filtered_questions(filter)),
         projects_aggregation(question_id, project_list)
           as
           (select id, string_agg(distinct projectName, '|') as project_list
            from filtered_question
            group by id),
         tags_aggregation(question_id, tag_list)
           as
           (select id, string_agg(distinct tagName, '|') as tag_list
            from filtered_question
            group by id)
    select fq.id::int8,
           fq.question::varchar,
           fq.shortAnswer::varchar,
           projects_aggregation.project_list::varchar as projects,
           fq.questionLevel::varchar                  as difficultyLevel,
           tags_aggregation.tag_list::varchar         as tags
    from filtered_question fq
           left join projects_aggregation on fq.id = projects_aggregation.question_id
           left join tags_aggregation on fq.id = tags_aggregation.question_id
    order by fq.id desc;
END;
$$ LANGUAGE plpgsql;
