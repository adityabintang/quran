class ErrorModel {
  int? code;
  String? message;

  ErrorModel.fromJson(Map<String, dynamic> json) {
    code = json["status"] ?? 404;
    message =
    json["message"] ?? "Something Went Wrong";
  }
}