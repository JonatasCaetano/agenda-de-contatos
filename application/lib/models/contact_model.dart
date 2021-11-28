import 'package:application/entities/contact.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContactModel extends Model {
  String text = '';
  String base = 'http://192.168.0.109:8080/contacts';

  Future<List<dynamic>> findAll() async {
    var url = Uri.parse(base + "/get");
    http.Response response = await http.get(url);
    List<dynamic> data = json.decode(response.body);
    return data;
  }

  findById({required int id}) {}

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
    // ignore: avoid_print
    print(response.statusCode);
    // ignore: avoid_print
    print(response.headers);
    // ignore: avoid_print
    print(response.body);
  }

  Future put({
    required Contact contact,
    required BuildContext context,
  }) async {}

  delete({required int id}) {}
}
