import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/provider/addTaskProvider.dart';
import 'package:task_manager/provider/userTaskListProvider.dart';
import 'package:task_manager/screens/login.dart';
import 'package:task_manager/widgets/bottomSheet.dart';
import 'package:task_manager/widgets/editBottomSheet.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

String userName = "Developer";
String uid = "";

class _MyHomePageState extends State<MyHomePage> {
  ProviderList prov = ProviderList();
  ProviderAdd prov1 = ProviderAdd();

  @override
  void initState() {
    super.initState();
    sharedPreferencesIntialize();
  }

  sharedPreferencesIntialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> jwtDecodeToken =
        JwtDecoder.decode(prefs.getString('token')!);
    userName = jwtDecodeToken['name'];
    uid = jwtDecodeToken['_id'];
    prov.fetchTasks(jwtDecodeToken['_id']);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    prov = Provider.of<ProviderList>(context);
    prov1 = Provider.of<ProviderAdd>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade300,
        toolbarHeight: MediaQuery.of(context).size.height / 4,
        title: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "TASK MANAGER",
                  style: TextStyle(
                    fontFamily: "chakramedium",
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                Divider(
                  indent: MediaQuery.of(context).size.width / 3,
                  endIndent: MediaQuery.of(context).size.width / 3,
                  height: 7.5,
                ),
                const Text(
                  "FLUTTER X NODEJS",
                  style: TextStyle(
                    fontFamily: "chakraregular",
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width / 6),
                    Text(
                      "Hello ${userName}",
                      style: TextStyle(
                        fontFamily: "chakraregular",
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        prov.fetchTasks(uid);
                      },
                      icon: Icon(
                        Icons.refresh_rounded,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool('isLogin', false);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                    (route) => false,
                  );
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: Stack(
        children: [
          Consumer<ProviderList>(
            builder: (BuildContext context, value, Widget? child) {
              print(value.posts.length);
              return value.posts.isEmpty && value.isLoading
                  ? Center(child: Text("LOADING..."))
                  : value.posts.isEmpty
                      ? Center(child: Text("NO TASKS"))
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: value.posts.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                left: 13,
                                right: 13,
                                top: index == 0 ? 14 : 7,
                                bottom: 10,
                              ),
                              child: Material(
                                elevation: 4,
                                child: ListTile(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      backgroundColor:
                                          Colors.deepPurple.shade100,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(30)),
                                      ),
                                      builder: (context) {
                                        return DraggableScrollableSheet(
                                          expand: true,
                                          initialChildSize: 1,
                                          builder: (BuildContext context,
                                              ScrollController
                                                  scrollController) {
                                            return EditBottomSheet(
                                              id: value.posts[index].id,
                                              title: value.posts[index].title
                                                  .toString(),
                                              desc: value.posts[index].desc
                                                  .toString(),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                  shape: Border(
                                    top: BorderSide(
                                        style: BorderStyle.solid, width: 1.75),
                                    left: BorderSide(
                                        style: BorderStyle.solid, width: 1.5),
                                  ),
                                  tileColor: Colors.deepPurple.shade200,
                                  title: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 5, top: 2.5),
                                    child: Text(
                                        value.posts[index].title.toString()),
                                  ),
                                  titleTextStyle: TextStyle(
                                    color: Colors.deepPurple.shade900,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    fontFamily: "chakrabold",
                                    letterSpacing: 0.75,
                                  ),
                                  subtitle:
                                      Text(value.posts[index].desc.toString()),
                                  subtitleTextStyle: TextStyle(
                                    fontSize: 15,
                                    height: 1.2,
                                    letterSpacing: 0.4,
                                    fontFamily: "chakraregular",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
            },
          ),
          prov1.isLoading || prov.isLoading
              ? Container(
                  color: Colors.deepPurple.shade50.withOpacity(0.5),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child:
                      SpinKitSpinningLines(color: Colors.deepPurple.shade600),
                )
              : Container(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple.shade200,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.deepPurple.shade100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            builder: (BuildContext context) {
              return DraggableScrollableSheet(
                expand: true,
                initialChildSize: 1,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return CustomBottomSheet();
                },
              );
            },
          );
        },
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
