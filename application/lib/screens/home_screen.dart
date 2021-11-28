import 'package:application/entities/contact.dart';
import 'package:application/models/contact_model.dart';
import 'package:application/screens/contact_screen.dart';
import 'package:application/screens/search_screen.dart';
import 'package:application/widgets/future_builder_widget.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String text = '';

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ContactModel>(
        builder: (context, child, contact) {
      return Scaffold(
        appBar: AppBar(title: Text("Contacts " + text), actions: [
          IconButton(
            onPressed: () async {
              // ignore: avoid_print
              print("abrir tela pesquisar contato por id");
              String result =
                  await showSearch(context: context, delegate: SearchScreen());
              setState(() {
                text = result;
              });
            },
            icon: const Icon(Icons.search),
          )
        ]),
        body: FutureBuilderWidget(
          text: text,
        ),
        floatingActionButton: FloatingActionButton(
          mini: true,
          child: const Icon(Icons.add),
          onPressed: () {
            //**salvar novo contato */
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ContactScreen(contact: Contact(0, "", ""))));
            // ignore: avoid_print
            print("abrir tela adicionar contato");
          },
        ),
      );
    });
  }
}
