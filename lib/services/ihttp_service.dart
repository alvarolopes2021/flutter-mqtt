abstract class IHttpService {
  Future<String> get();
  Future<String> post(String url, String route, Map<String, dynamic> data);
}