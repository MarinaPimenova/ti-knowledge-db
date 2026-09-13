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
           as (select fqs.id, fqs.question, fqs.shortAnswer, fqs.projectName, fqs.questionLevel, fqs.tagName
               from knowledge.get_filtered_questions(filter) as fqs),
         projects_aggregation(question_id, project_list)
           as
           (select fq1.id, string_agg(distinct fq1.projectName, '|') as project_list
            from filtered_question fq1
            group by fq1.id),
         tags_aggregation(question_id, tag_list)
           as
           (select fq2.id, string_agg(distinct fq2.tagName, '|') as tag_list
            from filtered_question fq2
            group by fq2.id)
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
