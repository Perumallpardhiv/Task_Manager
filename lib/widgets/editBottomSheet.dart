import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/provider/addTaskProvider.dart';

// ignore: must_be_immutable
class EditBottomSheet extends StatefulWidget {
  String? id;
  String? title;
  String? desc;
  EditBottomSheet(
      {required this.id, required this.title, required this.desc, super.key});
  @override
  State<EditBottomSheet> createState() => _EditBottomSheetState();
}

class _EditBottomSheetState extends State<EditBottomSheet> {
  ProviderAdd prov = ProviderAdd();
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();

  @override
  void initState() {
    super.initState();
    prov = Provider.of<ProviderAdd>(context, listen: false);
    controllerSetup();
  }

  controllerSetup() async {
    title = TextEditingController(text: widget.title);
    desc = TextEditingController(text: widget.desc);
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
                  "UPDATE TASK",
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
                        prov.deleteTask(widget.id!);
                        if (prov.message == "") {
                          Navigator.of(context).pop();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(prov.message)));
                        }
                      },
                      label: Icon(Icons.delete_outline_outlined),
                      icon: Text('Delete'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (title.text.isNotEmpty && desc.text.isNotEmpty) {
                          prov.updateTask(widget.id.toString(), title.text, desc.text);

                          if (prov.message == "") {
                            Navigator.of(context).pop();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(prov.message)));
                          }
                        }
                      },
                      label: Text('Edit'),
                      icon: Icon(Icons.edit_outlined),
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
