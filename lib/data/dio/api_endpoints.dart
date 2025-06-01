class ApiEndpoints {
  static const String baseUrl = 'https://dev.th3npc.org/guardias-uci';

  // Auth endpoints
  static const String login = '/api/auth/login';
  static const String register = '/api/auth/register';
  static const String activate = '/api/auth/activate';

  // User endpoints
  static const String currentUser = '/api/user/me';
  static const String users = '/api/user';
  static String userById(int id) => '/api/user/$id';

  // Guardia endpoints
  static const String guardias = '/api/guardia';
  static String guardiaById(int id) => '/api/guardia/$id';

  // Incident endpoints (si se implementan en el backend)
  static const String incidents = '/api/incidents';
  static String incidentById(int id) => '/api/incidents/$id';
}
