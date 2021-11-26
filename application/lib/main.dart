import 'package:application/models/contact_model.dart';
import 'package:application/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MaterialApp(
    home: ScopedModel<ContactModel>(model: ContactModel(), child: const Home()),
  ));
}
