class Contact {
  int _id = 0;
  String _name = "";
  String _phone = "";

  Contact(this._id, this._name, this._phone);

  Contact.fromMap(Map map) {
    _id = map["id"];
    _name = map["name"];
    _phone = map["phone"];
  }

  String get getPhone => _phone;

  set setPhone(String value) {
    _phone = value;
  }

  String get getName => _name;

  set setName(String value) {
    _name = value;
  }

  int get getId => _id;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": _id,
      "name": _name,
      "phone": _phone,
    };
    return map;
  }

  @override
  String toString() {
    return 'Contact{_id: $_id, _name: $_name, _phone: $_phone}';
  }
}
