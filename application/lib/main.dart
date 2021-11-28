import 'package:application/models/contact_model.dart';
import 'package:application/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ContactModel>(
        model: ContactModel(),
        child: const MaterialApp(
          home: HomeScreen(),
        ));
  }
}
