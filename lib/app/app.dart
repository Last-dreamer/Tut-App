import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resources/routes_manger.dart';
import 'package:tut_app/presentation/resources/theme_manager.dart';

class MyApp extends StatefulWidget {
  MyApp._internal();
  int appState = 0;
  static final MyApp instance = MyApp._internal();
  factory MyApp() => instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: getApplicationTheme(),
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.splashRoute,
        onGenerateRoute: RouteGenerator.getRoute);
  }
}
