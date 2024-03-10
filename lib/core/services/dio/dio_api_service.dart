import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import '../../models/api_response.dart';
import 'dio_error_handler.dart';

class DioApiService {
  Dio dio = Dio();
  final String _baseUrl = "https://api.openweathermap.org";

  DioApiService() {
    dio.options.headers.addAll({'Accept': 'application/json'});
  }

  Future<ApiResponse> post(
      {required Map<String, dynamic> body, required var url}) async {
    try {
      Response response =
          await dio.post("$_baseUrl/$url", data: json.encode(body));
      return DioResponseHandler.parseResponse(response);
    } on DioError catch (e) {
      return DioResponseHandler.dioErrorHandler(e);
    }
  }

  Future<ApiResponse> get({required String url}) async {
    try {
      Response response = await dio.get("$_baseUrl/$url");
      return DioResponseHandler.parseResponse(response);
    } on DioError catch (e) {
      return DioResponseHandler.dioErrorHandler(e);
    }
  }

  Future<ApiResponse> put(
      {required Map<String, dynamic> body, required var url}) async {
    try {
      Response response =
          await dio.put("$_baseUrl/$url", data: json.encode(body));
      return DioResponseHandler.parseResponse(response);
    } on DioError catch (e) {
      return DioResponseHandler.dioErrorHandler(e);
    }
  }
}

//DioApiService apiService = DioApiService();
