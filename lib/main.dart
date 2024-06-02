import 'package:flutter/material.dart';
import 'package:movieflix/screens/home_screen.dart';

void main() {
  runApp(const Movieflix());
}

class Movieflix extends StatelessWidget {
  const Movieflix({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movieflix',
      theme: ThemeData(
        primaryColor: const Color(0xffF9F9FB),
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
