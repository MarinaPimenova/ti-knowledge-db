
create or replace view knowledge.question_projection
as
select p.project_name,
       ql.code,
       t.tag,
       q.question,
       q.short_answer,
       r.resource_url,
       r.description,
       ce.language,
       ce.source_code,
       q.updated_by
from knowledge.question q
         left join knowledge.question_level ql on q.question_level_id = ql.id
         left join knowledge.question_tag qt on q.id = qt.question_id
         left join knowledge.tag t on qt.knowledge_tag_id = t.id
         left join knowledge.question_resource qr on q.id = qr.question_id
         left join knowledge.resource r on qr.resource_id = r.id
         left join knowledge.project_question pq on q.id = pq.question_id
         left join knowledge.project p on pq.project_id = p.id
         left join knowledge.question_code_example qce on q.id = qce.question_id
         left join knowledge.code_example ce on qce.code_example_id = ce.id
;