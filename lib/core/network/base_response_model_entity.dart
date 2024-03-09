class BaseResponseModel {
  BaseResponseModel({
    required this.status,
    required this.message,
    this.result,
  });

  int? status;
  String? message;
  dynamic result;

  BaseResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['result'] = result;
    return data;
  }
}
