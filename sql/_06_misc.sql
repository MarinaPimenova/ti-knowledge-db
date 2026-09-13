select * from databasechangelog;

select * from knowledge.questions_aggregated_by_tags();

select * from knowledge.project;
select * from knowledge.project_question;
select * from knowledge.question_level;
select * from knowledge.tag;
select * from knowledge.question;
--     projects     varchar(255),
--     difficulties varchar(255),
--     tags         varchar(255),
--     createdby    varchar(255)
SELECT *
FROM knowledge.view_filtered_questions(
        ROW('1,2', '1,2,3,4', '1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,36', 'SYSTEM')::knowledge.filter_params_type
     );

select * from knowledge.find_questions_by_pattern('java');

select qdp.id,
       qdp.tags,
       qdp.question,
       qdp.shortAnswer,
       qdp.resources,
       --qdp.description,
       qdp.projectName,
       qdp.updatedBy
from knowledge.question_dashboard_projection qdp
where qdp.updatedBy = 'test' or qdp.createdBy = 'SYSTEM'
;