abstract class Source{
  Future<String> login(Map<String, dynamic> user);
  Future<String> getEventslist(Map<String, dynamic> user);
  Future<String> getProfile(String username);
  Future<String> getTasklist(Map<String, dynamic> user);
}


