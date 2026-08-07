INSERT INTO knowledge.code_example
(question_id, language, source_code, created_by, created_date)
VALUES

    (
        1,
        'JAVA',
        'record Employee(Long id, String name) {}',
        'SYSTEM',
        now()
    ),

    (
        2,
        'JAVA',
        'List<String> names = list.stream().map(User::getName).toList();',
        'SYSTEM',
        now()
    ),

    (
        4,
        'JAVA',
        '@Service public class UserService {}',
        'SYSTEM',
        now()
    ),

    (
        5,
        'TEXT',
        'Authorization Code Flow: Browser -> Okta -> Gateway -> JWT',
        'SYSTEM',
        now()
    ),

    (
        10,
        'YAML',
        'strategy:
          rollingUpdate:
            maxUnavailable: 1',
        'SYSTEM',
        now()
    );