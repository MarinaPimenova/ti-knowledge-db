INSERT INTO knowledge.tag
(category_id, tag, description, created_by, created_date)
VALUES

-- Java
(1,'Streams','Java Stream API','SYSTEM',now()),
(1,'Virtual Threads','Project Loom','SYSTEM',now()),
(1,'Collections','Java Collections Framework','SYSTEM',now()),
(1,'Optional','Optional API','SYSTEM',now()),
(1,'Records','Java Records','SYSTEM',now()),
(1,'Pattern Matching','Java Pattern Matching','SYSTEM',now()),

-- Spring
(2,'Spring Boot','Spring Boot','SYSTEM',now()),
(2,'Spring Security','Security framework','SYSTEM',now()),
(2,'Spring Data JPA','Persistence layer','SYSTEM',now()),
(2,'Dependency Injection','IoC Container','SYSTEM',now()),
(2,'Spring MVC','REST APIs','SYSTEM',now()),

-- Security
(3,'OAuth2','OAuth2 Framework','SYSTEM',now()),
(3,'OpenID Connect','OIDC','SYSTEM',now()),
(3,'JWT','JSON Web Token','SYSTEM',now()),
(3,'CSRF','Cross Site Request Forgery','SYSTEM',now()),
(3,'XSS','Cross Site Scripting','SYSTEM',now()),

-- Databases
(4,'PostgreSQL','Relational database','SYSTEM',now()),
(4,'Liquibase','Database migrations','SYSTEM',now()),
(4,'Indexes','Performance tuning','SYSTEM',now()),

-- Messaging
(5,'RabbitMQ','AMQP broker','SYSTEM',now()),
(5,'Dead Letter Queue','DLQ','SYSTEM',now()),

-- Cloud
(6,'AWS','Amazon Web Services','SYSTEM',now()),
(6,'Amazon EKS','Kubernetes service','SYSTEM',now()),

-- Containers
(7,'Docker','Container platform','SYSTEM',now()),
(7,'Kubernetes','Container orchestration','SYSTEM',now()),

-- DevOps
(8,'GitHub Actions','CI/CD','SYSTEM',now()),
(8,'SonarQube','Static analysis','SYSTEM',now()),

-- Observability
(9,'OpenTelemetry','Distributed tracing','SYSTEM',now()),
(9,'Prometheus','Metrics','SYSTEM',now()),
(9,'Grafana','Dashboards','SYSTEM',now()),

-- Architecture
(10,'Microservices','Microservice architecture','SYSTEM',now()),
(10,'Event-Driven Architecture','EDA','SYSTEM',now()),
(10,'Resilience4j','Resilience library','SYSTEM',now()),
(10,'API Gateway','Gateway pattern','SYSTEM',now()),
(10,'Backend for Frontend','BFF pattern','SYSTEM',now());