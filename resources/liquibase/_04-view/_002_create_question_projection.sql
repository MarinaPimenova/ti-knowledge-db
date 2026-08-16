CREATE OR REPLACE VIEW knowledge.question_projection AS

SELECT
    q.id,
    q.question,
    q.short_answer              AS short_answer,
    q.detailed_answer           AS detailed_answer,

    (
        SELECT jsonb_build_object(
                       'questionLevelId', ql.id,
                       'difficultyCode', ql.code
               )
        FROM knowledge.question_level ql
        WHERE ql.id = q.question_level_id
    ) AS question_level,

    (
        SELECT jsonb_build_object(
                       'language', ce.language,
                       'sourceCode', ce.source_code
               )
        FROM knowledge.question_code_example qce
                 JOIN knowledge.code_example ce
                      ON ce.id = qce.code_example_id
        WHERE qce.question_id = q.id
        LIMIT 1
    ) AS code_example,

    (
        SELECT jsonb_agg(
                       jsonb_build_object(
                               'id', t.id,
                               'tag', t.tag
                       ) ORDER BY t.tag
               )
        FROM knowledge.question_tag qt
                 JOIN knowledge.tag t
                      ON t.id = qt.knowledge_tag_id
        WHERE qt.question_id = q.id
    ) AS tags,

    (
        SELECT jsonb_agg(
                       jsonb_build_object(
                               'id', r.id,
                               'url', r.resource_url,
                               'description', r.description
                       )
               )
        FROM knowledge.question_resource qr
                 JOIN knowledge.resource r
                      ON r.id = qr.resource_id
        WHERE qr.question_id = q.id
    ) AS resources,

    (
        SELECT jsonb_agg(
                       jsonb_build_object(
                               'id', p.id,
                               'name', p.project_name
                       )
               )
        FROM knowledge.project_question pq
                 JOIN knowledge.project p
                      ON p.id = pq.project_id
        WHERE pq.question_id = q.id
    ) AS projects,

    q.created_by,
    q.updated_by

FROM knowledge.question q
;