import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/provider/addTaskProvider.dart';

class CustomBottomSheet extends StatefulWidget {
  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  ProviderAdd prov = ProviderAdd();
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  String uid = "";

  @override
  void initState() {
    super.initState();
    prov = Provider.of<ProviderAdd>(context, listen: false);
    sharedPreferencesIntialize();
  }

  sharedPreferencesIntialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> jwtDecodeToken =
        JwtDecoder.decode(prefs.getString('token')!);
    uid = jwtDecodeToken['_id'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Consumer<ProviderAdd>(
          builder: (context, value, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "ADD NEW TASK",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.deepPurple.shade800,
                    fontWeight: FontWeight.bold,
                    fontFamily: "chakrabold",
                  ),
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: title,
                  decoration: InputDecoration(
                    fillColor: Colors.deepPurple.shade100,
                    filled: true,
                    prefixIcon: const Icon(Icons.task_alt_rounded),
                    prefixIconColor: Colors.deepPurple.shade600,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.5),
                      borderSide:
                          BorderSide(color: Colors.deepPurple.shade600),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.5),
                      borderSide:
                          BorderSide(color: Colors.deepPurple.shade600),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.5),
                      borderSide:
                          BorderSide(color: Colors.deepPurple.shade600),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.5),
                      borderSide:
                          BorderSide(color: Colors.deepPurple.shade600),
                    ),
                    hintText: 'Task Title',
                    labelText: 'Task Title',
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: desc,
                  decoration: InputDecoration(
                    fillColor: Colors.deepPurple.shade100,
                    filled: true,
                    prefixIcon: const Icon(Icons.description_rounded),
                    prefixIconColor: Colors.deepPurple.shade600,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.5),
                      borderSide:
                          BorderSide(color: Colors.deepPurple.shade600),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.5),
                      borderSide:
                          BorderSide(color: Colors.deepPurple.shade600),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.5),
                      borderSide:
                          BorderSide(color: Colors.deepPurple.shade600),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.5),
                      borderSide:
                          BorderSide(color: Colors.deepPurple.shade600),
                    ),
                    hintText: 'Description',
                    labelText: 'Description',
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      label: Icon(Icons.cancel_outlined),
                      icon: Text('Cancel'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (title.text.isNotEmpty && desc.text.isNotEmpty) {
                          prov.addTask(uid, title.text, desc.text);

                          if (prov.message == "") {
                            Navigator.of(context).pop();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(prov.message)));
                          }
                        }
                      },
                      label: Text('Add'),
                      icon: Icon(Icons.check_circle_outline_outlined),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
