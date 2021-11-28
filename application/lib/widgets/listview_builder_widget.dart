import 'package:application/models/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ListViewBuilderWidget extends StatefulWidget {
  const ListViewBuilderWidget({Key? key}) : super(key: key);

  @override
  _ListViewBuilderWidgetState createState() => _ListViewBuilderWidgetState();
}

class _ListViewBuilderWidgetState extends State<ListViewBuilderWidget> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ContactModel>(
        builder: (context, child, contact) {
      return FutureBuilder<List<String>>(
          //**obter todos os contatos */
          future: contact.findById(id: contact.text),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.active:
              case ConnectionState.waiting:
                // ignore: avoid_print
                print(snapshot.connectionState);
                return Container();
              case ConnectionState.done:
                if (!snapshot.hasData) {
                  return Container();
                } else {
                  // ignore: avoid_print
                  print(snapshot.connectionState);
                  List<String> _list = snapshot.data!;
                  return ListView.builder(
                      itemCount: _list.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            contact.text = _list[index].toString();
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              _list[index].toString(),
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        );
                      });
                }
            }
          });
    });
  }
}
