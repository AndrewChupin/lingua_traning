import 'dart:convert';

import 'package:http/http.dart';

class Human {
  final int id;
  final String name;
  final int age;

  Human({this.id, this.name, this.age});

  factory Human.fromJson(Map<String, dynamic> json) {
    return Human(
      id: json['id'],
      name: json['name'],
      age: json['age'],
    );
  }

  @override
  String toString() {
    return 'Human{id: $id, name: $name, age: $age}';
  }
}


Future<Stream<List<Human>>> fetchHumans() async {
  var client = Client();
  var streamRes = await client.send(
      Request("get", Uri.parse("http://192.168.0.240:5000/get_humans"))
  );
  
  return streamRes.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((jsonBody) => (jsonBody as List).map((f) => Human.fromJson(f)));
}
