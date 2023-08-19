import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple.shade300,
          toolbarHeight: 70,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "TASK MANAGER",
                style: TextStyle(
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
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          centerTitle: true,
          elevation: 2,
        ),
        body: const Center(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple.shade200,
          onPressed: (){},
          tooltip: 'Add Task',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
