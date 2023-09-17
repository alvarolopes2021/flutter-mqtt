abstract class IHttpService {
  Future<String> get();
  Future<String> post(String url, Map<String, dynamic> data);
}