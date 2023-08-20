import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/provider/addTaskProvider.dart';
import 'package:task_manager/provider/userTaskListProvider.dart';
import 'package:task_manager/screens/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProviderList()),
        ChangeNotifierProvider(create: (context) => ProviderAdd()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Splash(),
    );
  }
}
