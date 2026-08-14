select qdp.id,
       qdp.tag,
       qdp.question,
       qdp.shortAnswer,
       qdp.resourceUrl,
       qdp.description,
       qdp.projectName,
       qdp.updatedBy
from knowledge.question_dashboard_projection qdp
where qdp.updatedBy = 'test' or qdp.createdBy = 'SYSTEM'
;