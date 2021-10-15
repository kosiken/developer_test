import 'package:http/http.dart' as http;

class Company {
  final String name;
  final String catchPhrase;
  final String bs;

  Company(this.name, this.catchPhrase, this.bs);

  static Company fromJSON(Map<String, dynamic> json) {
    return Company(json["name"]!, json["catchPhrase"]!, json["bs"]!);
  }
}

class Address {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final Map<String, String> geo;

  const Address(
      {required this.street,
      required this.suite,
      required this.city,
      required this.zipcode,
      required this.geo});

  static Address fromJSON(Map<String, dynamic> json) {
    return Address(
        street: json["street"],
        suite: json["suite"],
        city: json["city"],
        zipcode: json["zipcode"],
        geo: json["geo"]);
  }
}

class JsonPlaceholderApiUser {
  final int id;
  final String name;
  final String email;
  final String username;
  final String phone;
  final String website;
  final Address address;

  final Company company;

  const JsonPlaceholderApiUser({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.phone,
    required this.website,
    required this.address,
    required this.company,
  });

  static JsonPlaceholderApiUser fromJSON(Map<String, dynamic> json) {
    Company company = Company.fromJSON(json["company"]!);

    Address address = Address.fromJSON(json["address"]!);

    return JsonPlaceholderApiUser(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        username: json["username"],
        phone: json["phone"],
        website: json["website"],
        address: address,
        company: company);
  }
}

class JsonPlaceholderApiTodo {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  const JsonPlaceholderApiTodo(
      this.userId, this.id, this.title, this.completed);

  @override
  String toString() {
    return title;
  }

  static JsonPlaceholderApiTodo fromJSON(Map<String, dynamic> json) {
    return JsonPlaceholderApiTodo(
        json["userId"]!, json["id"]!, json["title"]!, json["completed"]!);
  }
}

class JsonPlaceholderApiPost {
  final int userId;
  final int id;
  final String title;
  final String body;

  const JsonPlaceholderApiPost(this.userId, this.id, this.title, this.body);

  @override
  String toString() {
    return title;
  }

  static JsonPlaceholderApiPost fromJSON(Map<String, dynamic> json) {
    return JsonPlaceholderApiPost(
        json["userId"]!, json["id"]!, json["title"]!, json["body"]!);
  }
}
