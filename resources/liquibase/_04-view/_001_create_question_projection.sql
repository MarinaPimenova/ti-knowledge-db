create or replace view knowledge.question_dashboard_projection as
select q.id,
       t.tag,
       q.question,
       q.short_answer as shortAnswer,
       r.resource_url as resourceUrl,
       r.description,
       p.project_name as projectName,
       q.updated_by   as updatedBy
from knowledge.question q
         left join knowledge.question_tag qt on q.id = qt.question_id
         left join knowledge.tag t on qt.knowledge_tag_id = t.id
         left join knowledge.question_resource qr on q.id = qr.question_id
         left join knowledge.resource r on qr.resource_id = r.id
         left join knowledge.project_question pq on q.id = pq.question_id
         left join knowledge.project p on pq.project_id = p.id
;