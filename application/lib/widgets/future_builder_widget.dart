import 'package:application/entities/contact.dart';
import 'package:application/models/contact_model.dart';
import 'package:application/screens/contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class FutureBuilderWidget extends StatefulWidget {
  const FutureBuilderWidget({Key? key}) : super(key: key);

  @override
  _FutureBuilderWidgetState createState() => _FutureBuilderWidgetState();
}

class _FutureBuilderWidgetState extends State<FutureBuilderWidget> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ContactModel>(
        builder: (context, child, contact) {
      return FutureBuilder<List<dynamic>>(
          //**obter todos os contatos */
          future: contact.findAll(),
          builder: (context, snapshot) {
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
                if (!snapshot.hasData) {
                  return Container();
                } else {
                  List? _list = snapshot.data;
                  // ignore: avoid_print
                  print("datos recebidos: " + _list.toString());
                  return ListView.builder(
                      itemCount: contact.list.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                            direction: DismissDirection.endToStart,
                            onDismissed: (_) {
                              //***remover contato
                              contact.delete(
                                contact: Contact.fromMap(contact.list[index]),
                                context: context,
                                index: index,
                              );
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
                            key: Key(DateTime.now()
                                .millisecondsSinceEpoch
                                .toString()),
                            child: Card(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          contact.list[index]["id"].toString()),
                                    ),
                                    Expanded(
                                        child: Text("Nome: " +
                                            contact.list[index]["name"]
                                                .toString())),
                                    IconButton(
                                        onPressed: () {
                                          //***editar contato */
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ContactScreen(
                                                          contact: Contact
                                                              .fromMap(contact
                                                                      .list[
                                                                  index]))));
                                          // ignore: avoid_print
                                          print("abrir tela editar contato");
                                        },
                                        icon: const Icon(Icons.edit))
                                  ],
                                ),
                                subtitle: Text("Phone: " +
                                    contact.list[index]["phone"].toString()),
                              ),
                            )));
                      });
                }
            }
          });
    });
  }
}
