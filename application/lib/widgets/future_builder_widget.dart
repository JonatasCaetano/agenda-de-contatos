import 'package:application/entities/contact.dart';
import 'package:application/models/contact_model.dart';
import 'package:application/screens/contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

// ignore: must_be_immutable
class FutureBuilderWidget extends StatefulWidget {
  String text;

  // ignore: type_init_formals
  FutureBuilderWidget({required String this.text, Key? key}) : super(key: key);

  @override
  _FutureBuilderWidgetState createState() => _FutureBuilderWidgetState();
}

class _FutureBuilderWidgetState extends State<FutureBuilderWidget> {
  Future<List<String>> returnList({required String text}) async {
    List<String> list = ["test", "test", "test", "test", "test", "test"];
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ContactModel>(
        builder: (context, child, contact) {
      return FutureBuilder<List<String>>(
          //**obter todos os contatos */
          future: returnList(text: widget.text),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            } else {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.active:
                case ConnectionState.waiting:
                  // ignore: avoid_print
                  print(snapshot.connectionState);
                  return Container();
                case ConnectionState.done:
                  // ignore: avoid_print
                  print(snapshot.connectionState);
                  List<String> list2 = snapshot.data!;
                  return ListView.builder(
                      itemCount: list2.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                            direction: DismissDirection.endToStart,
                            onDismissed: (_) {
                              //***remover contato
                              // ignore: avoid_print
                              print("remover contato");
                            },
                            background: Container(
                              alignment: Alignment.centerRight,
                              color: Colors.red,
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            key: Key(list2[index]),
                            child: Card(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Row(
                                  children: [
                                    Expanded(
                                        child: Text("Nome: " +
                                            list2[index].toString())),
                                    IconButton(
                                        onPressed: () {
                                          //***editar contato */
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ContactScreen(
                                                          contact: Contact(
                                                              0,
                                                              "jonatas",
                                                              "14999999999"))));
                                          // ignore: avoid_print
                                          print("abrir tela editar contato");
                                        },
                                        icon: const Icon(Icons.edit))
                                  ],
                                ),
                                subtitle:
                                    Text("Phone: " + list2[index].toString()),
                              ),
                            )));
                      });
              }
            }
          });
    });
  }
}
