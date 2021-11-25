class Contact {
  int _id = 0;
  String _name = "";
  String _phone = "";

  Contact(this._id, this._name, this._phone);

  Contact.fromMap(Map map) {
    this._id = map["id"];
    this._name = map["name"];
    this._phone = map["phone"];
  }

  String get phone => _phone;

  set phone(String value) {
    _phone = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": this._id,
      "name": this._name,
      "phone": this._phone,
    };
    return map;
  }

  @override
  String toString() {
    return 'Contact{_id: $_id, _name: $_name, _phone: $_phone}';
  }
}
