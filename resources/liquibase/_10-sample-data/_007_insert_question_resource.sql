INSERT INTO knowledge.question_resource
(
    resource_id,
    question_id,
    created_by,
    created_date
)
VALUES

-- Java Record question
(1, 1, 'SYSTEM', now()),

-- Java Streams question
(2, 2, 'SYSTEM', now()),

-- Spring DI
(3, 4, 'SYSTEM', now()),

-- OAuth2
(4, 5, 'SYSTEM', now()),
(5, 5, 'SYSTEM', now()),

-- Authentication vs Authorization
(5, 6, 'SYSTEM', now()),

-- Event-driven microservices
(6, 8, 'SYSTEM', now()),

-- Kubernetes deployment
(7, 10, 'SYSTEM', now());