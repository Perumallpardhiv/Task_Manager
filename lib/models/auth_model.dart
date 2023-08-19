class AuthModel {
  bool? status;
  String? process;
  String? success;
  String? token;
  
  AuthModel({this.status, this.process, this.success, this.token});

  AuthModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    process = json['process'];
    success = json['success'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['process'] = this.process;
    data['success'] = this.success;
    data['token'] = this.token;
    return data;
  }
}
