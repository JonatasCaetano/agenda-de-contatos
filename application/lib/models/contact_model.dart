import 'package:application/entities/contact.dart';
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

  post({required Contact contact}) async {}

  put({required int id, required Contact contact}) {}

  delete({required int id}) {}
}
