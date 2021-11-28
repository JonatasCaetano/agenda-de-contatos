import 'package:application/models/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

// ignore: must_be_immutable
class ListViewBuilderWidget extends StatefulWidget {
  String text;
  ListViewBuilderWidget({required this.text, Key? key}) : super(key: key);

  @override
  _ListViewBuilderWidgetState createState() => _ListViewBuilderWidgetState();
}

class _ListViewBuilderWidgetState extends State<ListViewBuilderWidget> {
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
                        return GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              list2[index].toString(),
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
