INSERT INTO knowledge.code_example
(
    language,
    source_code,
    created_by,
    created_date
)
VALUES

    (
        'JAVA',
        'public record Employee(Long id, String name) {}',
        'SYSTEM',
        now()
    ),

    (
        'JAVA',
        'List<String> names = users.stream()
        .map(User::getName)
        .toList();',
        'SYSTEM',
        now()
    ),

    (
        'JAVA',
        '@Service
    public class UserService {

        private final UserRepository repository;

        public UserService(UserRepository repository) {
            this.repository = repository;
        }
    }',
        'SYSTEM',
        now()
    ),

    (
        'TEXT',
        'Authorization Code Flow:

    Browser
       |
       v
    Okta Login
       |
       v
    Gateway creates session
       |
       v
    Backend services use JWT',
        'SYSTEM',
        now()
    ),

    (
        'YAML',
        'strategy:
      rollingUpdate:
        maxUnavailable: 1
        maxSurge: 1',
        'SYSTEM',
        now()
    );