class userTask {
  bool? status;
  AddTask? success;

  userTask({this.status, this.success});

  userTask.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success =
        json['success'] != null ? new AddTask.fromJson(json['success']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.success != null) {
      data['success'] = this.success?.toJson();
    }
    return data;
  }
}

class AddTask {
  String? userId;
  String? title;
  String? desc;
  String? id;

  AddTask({this.userId, this.title, this.desc, this.id});

  AddTask.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    title = json['title'];
    desc = json['desc'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['_id'] = this.id;
    return data;
  }
}
