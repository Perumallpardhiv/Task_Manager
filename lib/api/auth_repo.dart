import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_manager/const/base_url.dart';
import 'package:task_manager/models/auth_model.dart';

class AuthRepository {
  Future authResponse(String name) async {
    var postBody = {"name": name};
    print(name);
    Uri url = Uri.parse("${ApiUrl.baseUrl}${ApiUrl.registerLogin}");
    final response = await http.post(
      url,
      body: jsonEncode(postBody),
      headers: {"Content-Type": "application/json"},
    );
    return AuthModel.fromJson(jsonDecode(response.body));
  }
}
