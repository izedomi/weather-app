import 'package:dio/dio.dart';
import '../../models/api_response.dart';

class DioResponseHandler {
  static String errorMsg = "Error occured. Please try again later";
  static ApiResponse parseResponse(Response res) {
    // print("Response Code: ${res.statusCode}");
    // print("Response Body: ${res.data}");

    try {
      late dynamic response = res.data;

      if (res.statusCode == 200 ||
          res.statusCode == 201 ||
          res.statusCode == 202) {
        try {
          return ApiResponse(
              code: res.statusCode,
              success: true,
              message: response["message"].toString(),
              data: response ?? "Success");
        } catch (e) {
          // printty(e.toString());
          return ApiResponse(
            code: res.statusCode,
            success: false,
            message: e.toString(),
          );
        }
      } else if (res.statusCode! >= 400 || res.statusCode! <= 404) {
        return ApiResponse(
            code: res.statusCode,
            success: false,
            message: response["message"] ?? errorMsg);
      } else {
        return ApiResponse(
            code: res.statusCode, success: false, message: response["message"]);
      }
    } catch (e) {
      return ApiResponse(
          code: res.statusCode, success: false, message: errorMsg);
    }
  }

  static ApiResponse dioErrorHandler(DioError e) {
    final dioError = e;
    switch (dioError.type) {
      case DioErrorType.badResponse:
        // print("error response: ${dioError.response!.statusCode}");
        // print("error response: ${dioError.response!.data}");
        try {
          return ApiResponse(
              code: dioError.response!.statusCode,
              success: false,
              message: dioError.response!.data["message"] ?? errorMsg);
        } catch (e) {
          return ApiResponse(
              code: dioError.response!.statusCode,
              success: false,
              message: errorMsg);
        }

      case DioErrorType.cancel:
        return ApiResponse(code: 500, success: false, message: errorMsg);
      case DioErrorType.connectionTimeout:
        return ApiResponse(
            code: 500, success: false, message: "Connection Timed Out");
      case DioErrorType.unknown:
        return ApiResponse(code: 500, success: false, message: errorMsg);
      case DioErrorType.sendTimeout:
        return ApiResponse(
            code: 500, success: false, message: "Sender Connection Timed Out");
      case DioErrorType.receiveTimeout:
        return ApiResponse(
            code: 500,
            success: false,
            message: "Reciever Connection Timed Out");
      default:
        return ApiResponse(code: 500, success: false, message: errorMsg);
    }
  }
}
