import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:navigation_app/Firestore/firestore_screen.dart';
import 'package:navigation_app/TodoList/post_screen.dart';
// import 'package:navigation_app/post_screen.dart';
// import '/authentication/screens/homepage_screen.dart';
//import '/authentication/screens/splash_screen.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
      ),
      home: const PostScreen(),
    );
  }
}