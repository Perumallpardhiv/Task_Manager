class userTaskResponseModel {
  bool? status;
  List<userTaskList>? success;

  userTaskResponseModel({required this.status, required this.success});

  userTaskResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['success'] != null) {
      success = <userTaskList>[];
      json['success'].forEach((v) {
        success?.add(new userTaskList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.success != null) {
      data['success'] = this.success?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class userTaskList {
  String? id;
  String? userId;
  String? title;
  String? desc;

  userTaskList({required this.id, required this.userId, required this.title, required this.desc});

  userTaskList.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userId = json['userId'];
    title = json['title'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['userId'] = this.userId;
    data['title'] = this.title;
    data['desc'] = this.desc;
    return data;
  }
}
