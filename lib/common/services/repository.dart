import 'package:dio/dio.dart';

String url = 'http://qpay-app.rgvlabs.com/api/';

class ApiService {
  final Dio _dio = Dio();

  // Base URL for the API
  final String baseUrl;

  ApiService({required this.baseUrl}) {
    _dio.options.baseUrl = baseUrl;
  }

  // GET request
  Future<Response> getRequest(String endpoint) async {
    try {
      Response response = await _dio.get(baseUrl + endpoint);
      return response;
    } on DioException catch (e) {
      throw Exception('GET request failed: ${e.message}');
    }
  }

  // POST request
  Future<Response> postRequest(
      String endpoint, Map<String, dynamic> data) async {
    try {
      String finalUrl = baseUrl + endpoint;
      print("Request POST to $finalUrl, data: $data");
      Response response = await _dio.post(finalUrl, data: data);
      return response;
    } on DioException catch (e) {
      throw Exception('POST request failed: ${e.message}');
    }
  }

  // PATCH request
  Future<Response> patchRequest(
      String endpoint, Map<String, dynamic> data) async {
    try {
      String finalUrl = baseUrl + endpoint;
      print("Request PATCH to $finalUrl, data: $data");
      Response response = await _dio.patch(finalUrl, data: data);
      return response;
    } on DioException catch (e) {
      throw Exception('PATCH request failed: ${e.message}');
    }
  }
}

ApiService apiService = ApiService(baseUrl: url);
