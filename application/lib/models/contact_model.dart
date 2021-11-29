import 'package:application/entities/contact.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContactModel extends Model {
  String text = '';
  List list = [];
  String base = 'http://192.168.0.109:8080/contacts';

  Future<List<dynamic>> findAll() async {
    var url = Uri.parse(base + "/get");
    http.Response response = await http.get(url);
    List<dynamic> data = json.decode(response.body);
    if (response.statusCode == 200) {
      list = data;
    }
    return list;
  }

  Future<List<dynamic>> findById({required String id}) async {
    if (id.isNotEmpty) {
      var url = Uri.parse(base + "/get/" + id);
      http.Response response = await http.get(url);
      Map<dynamic, dynamic> map = json.decode(response.body);
      list = [];
      if (response.statusCode == 200) {
        list.add(map);
      }
    }
    return list;
  }

  Future post({required Contact contact, required BuildContext context}) async {
    var url = Uri.parse(base + "/post");
    var body = json.encode({
      "name": contact.getName,
      "phone": contact.getPhone,
    });
    http.Response response = await http.post(
      url,
      headers: {"Content-type": "application/json; charset=UTF-8"},
      body: body,
    );
    if (response.statusCode == 201) {
      Navigator.pop(context);
    }
  }

  put({
    required Contact contact,
    required BuildContext context,
  }) async {
    var url = Uri.parse(base + "/put/${contact.getId}");
    var body = json.encode({
      "name": contact.getName,
      "phone": contact.getPhone,
    });
    http.Response response = await http.put(
      url,
      headers: {"Content-type": "application/json; charset=UTF-8"},
      body: body,
    );
    if (response.statusCode == 202) {
      Navigator.pop(context);
    }
  }

  delete(
      {required int index,
      required Contact contact,
      required BuildContext context}) async {
    var url = Uri.parse(base + "/delete/${contact.getId}");
    // ignore: unused_local_variable
    http.Response response = await http.delete(
      url,
      headers: {"Content-type": "application/json; charset=UTF-8"},
    );
    list.removeAt(index);
    // ignore: avoid_print
  }
}
