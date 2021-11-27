import 'package:application/models/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<String>> returnList() async {
    List<String> list = ["test", "test", "test", "test", "test", "test"];
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ContactModel>(
        builder: (context, child, contact) {
      return Scaffold(
        appBar: AppBar(title: const Text("Contacts"), actions: [
          IconButton(
            onPressed: () {
              // ignore: avoid_print
              print("abrir tela pesquisar contato por id");
            },
            icon: const Icon(Icons.search),
          )
        ]),
        body: FutureBuilder<List<String>>(
            //**obter todos os contatos */
            future: returnList(),
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
            }),
        floatingActionButton: FloatingActionButton(
          mini: true,
          child: const Icon(Icons.add),
          onPressed: () {
            //**salvar novo contato */
            // ignore: avoid_print
            print("abrir tela adicionar contato");
          },
        ),
      );
    });
  }
}