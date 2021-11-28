import 'package:application/entities/contact.dart';
import 'package:application/models/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

// ignore: must_be_immutable
class ContactScreen extends StatefulWidget {
  Contact contact;

  ContactScreen({required this.contact, Key? key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  void initState() {
    super.initState();
    name.text = widget.contact.getName;
    phone.text = widget.contact.getPhone;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ContactModel>(
        builder: (context, child, contact) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Contact"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: name,
                decoration: const InputDecoration(label: Text("name")),
              ),
              TextField(
                controller: phone,
                decoration: const InputDecoration(label: Text("phone")),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          mini: true,
          child: const Icon(Icons.save),
          onPressed: () {
            Contact _contact = Contact(0, name.text, phone.text);
            //**salvar novo contato */
            if (widget.contact.getName.isEmpty) {
              contact.post(contact: _contact);
            } else {
              contact.put(id: widget.contact.getId, contact: _contact);
            }
            // ignore: avoid_print
            print("salvar contato");
          },
        ),
      );
    });
  }
}
