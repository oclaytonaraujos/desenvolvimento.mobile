import 'package:flutter/material.dart';
import 'package:mamamia_pizzaria/login/login.dart';
// ignore: unused_import
import 'package:mamamia_pizzaria/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mamamia Pizzaria',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        // Outra página do app
      },
    );
  }
}
