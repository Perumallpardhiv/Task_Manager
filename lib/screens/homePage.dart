import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

String userName = "Developer";

class _MyHomePageState extends State<MyHomePage> {
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade300,
        toolbarHeight: 100,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "TASK MANAGER",
              style: TextStyle(
                fontFamily: "chakramedium",
                fontWeight: FontWeight.bold,
                fontSize: 22.5,
                color: Colors.white,
              ),
            ),
            Divider(
              indent: MediaQuery.of(context).size.width / 4.5,
              endIndent: MediaQuery.of(context).size.width / 4.5,
              height: 7.5,
            ),
            const Text(
              "FLUTTER X NODEJS",
              style: TextStyle(
                fontFamily: "chakraregular",
                fontWeight: FontWeight.bold,
                fontSize: 10,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Hello ${userName}",
              style: TextStyle(
                fontFamily: "chakraregular",
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: 20,
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
                shape: Border(
                  top: BorderSide(style: BorderStyle.solid, width: 1.5),
                  left: BorderSide(style: BorderStyle.solid, width: 1.25),
                ),
                tileColor: Colors.deepPurple.shade200,
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 7.5, top: 5),
                  child: Text("First Task"),
                ),
                titleTextStyle: TextStyle(
                  color: Colors.deepPurple.shade900,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  letterSpacing: 0.75,
                ),
                subtitle: Text(
                  "By default, the ListTile in flutter can display only 2 lines. The Title and the SubTitle. In case there is a third line of text to be displayed, the isThreeLine is set to true and can allow another line to be present. The subtitle will be taking care of giving the 3rd line of text.",
                ),
                subtitleTextStyle: TextStyle(
                  fontSize: 15,
                  height: 1.2,
                  letterSpacing: 0.4,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple.shade200,
        onPressed: () {
          
        },
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
