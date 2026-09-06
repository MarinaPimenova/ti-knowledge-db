create or replace view knowledge.question_dashboard_projection as
with aggregated_tags (question_id, tags)
         as (SELECT qt.question_id,
                    string_agg(t.tag, ' | ' ORDER BY t.tag) as tags
             FROM knowledge.question_tag qt
                      JOIN knowledge.tag t ON t.id = qt.knowledge_tag_id
             group by qt.question_id),
     aggregated_resources
         AS (SELECT qr.question_id,
                    string_agg(
                            CASE
                                WHEN r.resource_url IS NOT NULL AND r.description IS NOT NULL
                                    THEN r.resource_url || ' (' || r.description || ')'
                                WHEN r.resource_url IS NOT NULL THEN r.resource_url
                                ELSE r.description
                                END,
                            ' | ' ORDER BY r.resource_url
                    ) AS resources
             FROM knowledge.question_resource qr
                      JOIN knowledge.resource r ON r.id = qr.resource_id
             GROUP BY qr.question_id),
     aggregated_projects
         AS (SELECT pq.question_id,
                    string_agg(p.project_name, ' | ' ORDER BY p.project_name) AS projects
             FROM knowledge.project_question pq
                      JOIN knowledge.project p ON p.id = pq.project_id
             GROUP BY pq.question_id)
select q.id,
       at.tags,
       q.question,
       q.short_answer             as shortAnswer,
       COALESCE(ar.resources, '') AS resources,
       COALESCE(ap.projects, '')  AS projectName,
       q.updated_by               as updatedBy,
       q.created_by               as createdBy,
       q.created_date             as createdDate
from knowledge.question q
         left join aggregated_tags at on q.id = at.question_id
         LEFT JOIN aggregated_resources ar ON q.id = ar.question_id
         left join aggregated_projects ap on q.id = ap.question_id
order by q.created_date desc
;