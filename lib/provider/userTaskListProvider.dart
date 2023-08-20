import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager/const/base_url.dart';
import 'package:task_manager/models/todo_model.dart';

class ProviderList with ChangeNotifier {
  List<userTaskList>? posts = [];
  bool isLoading = true;
  String message = "";

  Future fetchTasks(String userId) async {
    // isLoading = true;
    // notifyListeners();

    try {
      var postBody = {"userId": userId};
      Uri url = Uri.parse("${ApiUrl.baseUrl}${ApiUrl.getUserallTodoList}");
      final response = await http.post(
        url,
        body: jsonEncode(postBody),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        userAllTaskResponseModel res = userAllTaskResponseModel.fromJson(
          jsonDecode(response.body),
        );
        posts = res.success;
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        message = "Getting Tasks Failed";
        notifyListeners();
      }
    } catch (e) {
      message = e.toString();
      print(e);
    }
  }
}
