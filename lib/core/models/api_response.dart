class ApiResponse {
  bool success;
  dynamic data;
  String? message;
  int? code;

  ApiResponse({required this.success, this.data, this.message, this.code});
}
