INSERT INTO knowledge.question
(
    question_level_id,
    question,
    short_answer,
    detailed_answer,
    created_by,
    created_date
)
VALUES

    (
        1,
        'What is a Java Record?',
        'A Java Record is a special kind of class introduced in Java 16 that is designed to represent immutable data objects with less boilerplate code.',
        'Records automatically generate constructor, getters, equals(), hashCode(), and toString() methods. They are ideal for DTOs and immutable data carriers. Records cannot extend another class but can implement interfaces. The fields are final by default, which helps create safer and more predictable data structures.',
        'SYSTEM',
        now()
    ),

    (
        2,
        'Explain Java Stream API.',
        'Java Stream API allows processing collections in a declarative way using operations like filter, map, and collect without modifying the original data source.',
        'Streams provide a functional programming approach for processing sequences of elements. Intermediate operations such as filter(), map(), and sorted() are lazy and executed only when a terminal operation like collect(), reduce(), or forEach() is called. Streams can also be executed in parallel using parallelStream(), but this should be used carefully because of thread-safety and performance considerations.',
        'SYSTEM',
        now()
    ),

    (
        2,
        'What is Optional used for?',
        'Optional is a Java container object that represents the presence or absence of a value and helps avoid NullPointerException.',
        'Optional is mainly used as a return type when a method may not have a result. It encourages developers to explicitly handle missing values using methods like orElse(), orElseGet(), map(), and ifPresent(). Optional should generally not be used for entity fields, method parameters, or serialization models.',
        'SYSTEM',
        now()
    ),

    (
        3,
        'How does Spring Dependency Injection work?',
        'Dependency Injection is a Spring mechanism where objects receive their dependencies from the Spring container instead of creating them manually.',
        'Spring IoC container manages object creation and lifecycle. Beans are registered using annotations such as @Component, @Service, and @Repository or configuration classes. Dependencies are injected mainly through constructors, which improves testability and makes components loosely coupled. The container resolves dependencies based on type and configuration.',
        'SYSTEM',
        now()
    ),

    (
        3,
        'Explain OAuth2 Authorization Code Flow.',
        'OAuth2 Authorization Code Flow is a secure authentication flow where a user authenticates with an authorization server and the application receives authorization codes that are exchanged for tokens.',
        'The user is redirected from the application to the authorization server login page. After successful authentication, the authorization server redirects back with an authorization code. The backend exchanges this code for access and ID tokens. This flow is recommended for server-side applications because tokens are not exposed directly to the browser. In the Internal Knowledge Platform, the Gateway service acts as an OAuth2 Client integrated with Okta.',
        'SYSTEM',
        now()
    ),

    (
        3,
        'What is the difference between Authentication and Authorization?',
        'Authentication verifies who the user is, while authorization determines what actions the user is allowed to perform.',
        'Authentication happens first and establishes user identity, for example through OAuth2 login with Okta. Authorization happens afterwards and checks permissions or roles. For example, an authenticated user may access questions, but only users with admin privileges may delete them.',
        'SYSTEM',
        now()
    ),

    (
        4,
        'Explain the Circuit Breaker pattern.',
        'Circuit Breaker is a resilience pattern that prevents repeated calls to an unavailable service and allows the system to recover gracefully.',
        'The Circuit Breaker monitors failures of remote calls. When failures exceed a configured threshold, the circuit switches to OPEN state and temporarily blocks calls. After a recovery period it moves to HALF_OPEN state and allows test requests. If successful, it closes again. Libraries like Resilience4j provide Circuit Breaker, Retry, Timeout, and Fallback capabilities.',
        'SYSTEM',
        now()
    ),

    (
        4,
        'How would you design an Event-Driven Microservice Architecture?',
        'An Event-Driven Architecture uses asynchronous communication through events to achieve loose coupling and scalability between services.',
        'Services communicate by publishing and consuming domain events through a message broker such as RabbitMQ. Each service owns its database and processes events independently. This improves scalability and fault tolerance. Challenges include event versioning, duplicate message handling, retries, monitoring, and eventual consistency.',
        'SYSTEM',
        now()
    ),

    (
        4,
        'What are the benefits of Backend for Frontend (BFF)?',
        'BFF is a backend layer designed specifically for a frontend application that simplifies communication between UI and backend services.',
        'The BFF pattern allows the frontend to communicate with one backend service instead of multiple microservices. It can aggregate responses, handle authentication, transform data models, and apply frontend-specific security rules. In the Internal Knowledge Platform, ti-gateway-api acts as both API Gateway and BFF for the React application.',
        'SYSTEM',
        now()
    ),

    (
        4,
        'Explain Kubernetes rolling deployment.',
        'Rolling deployment updates application instances gradually without downtime by replacing old versions with new ones step by step.',
        'Kubernetes rolling deployment creates new pods with the updated application version while gradually terminating old pods. Parameters like maxUnavailable and maxSurge control the update process. Health checks ensure that only healthy pods receive traffic. This approach enables zero-downtime deployments and quick rollback if problems occur.',
        'SYSTEM',
        now()
    );