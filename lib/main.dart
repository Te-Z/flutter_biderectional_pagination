import 'package:flutter/material.dart';
import 'package:flutter_biderectional_pagination/di/di_initializer.dart';
import 'package:flutter_biderectional_pagination/pages/home_page.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends HookWidget {
   MyApp({super.key});

  final diInitializer = DiInitializer();

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      diInitializer.setUp();
      return null;
    });

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
