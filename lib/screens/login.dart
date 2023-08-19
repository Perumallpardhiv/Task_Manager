import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/api/auth_repo.dart';
import 'package:task_manager/models/auth_model.dart';
import 'package:task_manager/screens/homePage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController controller = TextEditingController();
  bool isLoading = false;
  late final SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    sharedPreferencesIntialize();
  }

  sharedPreferencesIntialize() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "TASK MANAGER",
                    style: TextStyle(
                      color: Colors.deepPurple.shade500,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontFamily: 'chakrabold',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 70),
                TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    fillColor: Colors.deepPurple.shade100,
                    filled: true,
                    prefixIcon: const Icon(Icons.person_rounded),
                    prefixIconColor: Colors.deepPurple.shade600,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.5),
                      borderSide: BorderSide(color: Colors.deepPurple.shade600),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.5),
                      borderSide: BorderSide(color: Colors.deepPurple.shade600),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.5),
                      borderSide: BorderSide(color: Colors.deepPurple.shade600),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.5),
                      borderSide: BorderSide(color: Colors.deepPurple.shade600),
                    ),
                    hintText: 'Your Name',
                    labelText: 'Name',
                  ),
                ),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (controller.text.isNotEmpty) {
                        try {
                          isLoading = true;
                          setState(() {});

                          AuthModel res = await AuthRepository().authResponse(
                            controller.text.toLowerCase(),
                          );
                          if (res.status ?? false) {
                            isLoading = false;
                            prefs.setBool('isLogin', true);
                            prefs.setString('token', res.token.toString());
                            // ignore: use_build_context_synchronously
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MyHomePage(),
                              ),
                              (route) => false,
                            );
                            SnackBar snackBar = SnackBar(
                              content:
                                  Center(child: Text(res.success.toString())),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            isLoading = false;
                            SnackBar snackBar = SnackBar(
                              content:
                                  Center(child: Text(res.success.toString())),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        } catch (e) {
                          print(e);
                          isLoading = false;
                          SnackBar snackBar = SnackBar(
                            content: Center(child: Text(e.toString())),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                        setState(() {});
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple.shade600,
                    ),
                    child: Row(
                      textBaseline: TextBaseline.alphabetic,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Add Tasks",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          isLoading
              ? Container(
                  color: Colors.deepPurple.shade50.withOpacity(0.5),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.deepPurple.shade600,
                      strokeWidth: 2,
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
