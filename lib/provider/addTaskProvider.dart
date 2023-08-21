import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager/const/base_url.dart';
import 'package:task_manager/models/add_todo_model.dart';

class ProviderAdd with ChangeNotifier {
  var task;
  bool isLoading = false;
  String message = "";

  Future addTask(String userId, String title, String desc) async {
    isLoading = true;
    message = "";
    notifyListeners();

    try {
      var postBody = {
        "userId": userId,
        "title": title,
        "desc": desc,
      };
      Uri url = Uri.parse("${ApiUrl.baseUrl}${ApiUrl.createTodo}");
      final response = await http.post(
        url,
        body: jsonEncode(postBody),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        userTask res = userTask.fromJson(
          jsonDecode(response.body),
        );
        task = res.success;
        isLoading = false;
        notifyListeners();
      } else {
        message = "Adding Task Failed";
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      message = e.toString();
      print(e);
    }
  }

  Future deleteTask(String id) async {
    isLoading = true;
    message = "";
    notifyListeners();

    try {
      var postBody = {"id": id};
      Uri url = Uri.parse("${ApiUrl.baseUrl}${ApiUrl.deleteTodo}");
      final response = await http.post(
        url,
        body: jsonEncode(postBody),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        userTask res = userTask.fromJson(
          jsonDecode(response.body),
        );
        task = res.success;
        isLoading = false;
        notifyListeners();
      } else {
        message = "Deleting Task Failed";
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      message = e.toString();
      print(e);
    }
  }

  Future updateTask(String id, String title, String desc) async {
    isLoading = true;
    message = "";
    notifyListeners();

    try {
      var postBody = {"id": id, "title": title, "desc": desc};
      Uri url = Uri.parse("${ApiUrl.baseUrl}${ApiUrl.updateTodo}");
      final response = await http.post(
        url,
        body: jsonEncode(postBody),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        userTask res = userTask.fromJson(
          jsonDecode(response.body),
        );
        task = res.success;
        isLoading = false;
        notifyListeners();
      } else {
        message = "Updating Task Failed";
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      message = e.toString();
      print(e);
    }
  }
}
