import 'package:flutter/material.dart';
import 'package:flutter_application_eval/app_routes.dart';
import 'package:flutter_application_eval/ecran_details.dart';
import 'package:flutter_application_eval/note.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Evaluation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: home,
      routes: routes,
      onGenerateRoute: (settings) {
        if (settings.name == details) {
          return MaterialPageRoute(
            builder: (context) => DetailsPage(
              note: settings.arguments as Note,
            ),
          );
        }
      },
    );
  }
}