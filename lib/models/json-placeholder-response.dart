import 'dart:html';

import 'package:developer_test/widgets/typography.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Company {
  final String name;
  final String catchPhrase;
  final String bs;

  Company(this.name, this.catchPhrase, this.bs);

  static Company fromJSON(dynamic json) {
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

  static Address fromJSON(dynamic json) {
    Map<String, String> geo = {};
    geo["lat"] = json["geo"]["lat"];
    geo["lng"] = json["geo"]["lng"];
    return Address(
        street: json["street"],
        suite: json["suite"],
        city: json["city"],
        zipcode: json["zipcode"],
        geo: geo);
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

  static JsonPlaceholderApiUser fromJSON(dynamic json) {
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

  @override
  String toString() {
    return name;
  }

  String getAvatarString() {
    var s = name.toUpperCase().split(" ");
    print(s.length);
    if (s.length <= 1) return s[0].substring(0, 1);
    return ("${s[0].substring(0, 1)}${s[1].substring(0, 1)}").toUpperCase();
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

  static JsonPlaceholderApiTodo fromJSON(dynamic json) {
    return JsonPlaceholderApiTodo(
        json["userId"]!, json["id"]!, json["title"]!, json["completed"]!);
  }
}

abstract class Describeable {
  Widget build(BuildContext context);
  String screenName();
}

class JsonPlaceholderApiPost implements Describeable {
  final int userId;
  final int id;
  final String title;
  final String body;

  const JsonPlaceholderApiPost(this.userId, this.id, this.title, this.body);

  @override
  String toString() {
    return title;
  }

  static JsonPlaceholderApiPost fromJSON(dynamic json) {
    return JsonPlaceholderApiPost(
        json["userId"]!, json["id"]!, json["title"]!, json["body"]!);
  }

  @override
  Widget build(BuildContext context) {
    JsonPlaceholderApiPost post = this;
    return Column(
      children: [
        //;

        SizedBox(
          height: 50,
        ),
        Expanded(
            child: ListView(
          children: [
            KosyText(
              post.title,
              type: TextTypes.header,
            ),
            SizedBox(
              height: 10,
            ),
            KosyText(
              post.body,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ))
      ],
    );
  }

  @override
  String screenName() {
    return "Post";
  }
}

class JsonPlaceholderApiComment implements Describeable {
  final int id;
  final String name;
  final String email;
  final int postId;
  final String body;

  @override
  String toString() {
    // TODO: implement toString
    return name;
  }

  const JsonPlaceholderApiComment(
      {required this.id,
      required this.name,
      required this.email,
      required this.postId,
      required this.body});

  static JsonPlaceholderApiComment fromJSON(dynamic json) {
    return JsonPlaceholderApiComment(
        id: json["id"]!,
        name: json["name"]!,
        email: json["email"]!,
        postId: json["postId"],
        body: json["body"]!);
  }

  @override
  Widget build(BuildContext context) {
    JsonPlaceholderApiComment comment = this;
    return Column(
      children: [
        //;

        SizedBox(
          height: 50,
        ),
        Expanded(
            child: ListView(
          children: [
            KosyText(
              comment.name,
              bold: true,
            ),
            SizedBox(
              height: 10,
            ),
            KosyText(
              comment.email,
              type: TextTypes.small,
            ),
            SizedBox(
              height: 10,
            ),
            KosyText(
              comment.body,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ))
      ],
    );
  }

  @override
  String screenName() {
    return "Comment";
  }
}

class JsonPlaceholderApiAlbum implements Describeable {
  final int id;
  final String title;
  final int userId;

  const JsonPlaceholderApiAlbum(this.id, this.title, this.userId);

  @override
  String toString() {
    return title;
  }

  static JsonPlaceholderApiAlbum fromJSON(dynamic json) {
    return JsonPlaceholderApiAlbum(json["id"], json["title"], json["userId"]);
  }

  @override
  String screenName() {
    return "Album";
  }

  @override
  Widget build(BuildContext context) {
    JsonPlaceholderApiAlbum album = this;
    return Column(
      children: [
        //;

        SizedBox(
          height: 50,
        ),
        Expanded(
            child: ListView(
          children: [
            KosyText(
              album.title,
              type: TextTypes.header,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ))
      ],
    );
  }
}

class JsonPlaceholderApiPhoto implements Describeable {
  final int id;
  final String title;
  final String url;
  final int albumId;
  @override
  String toString() {
    return title;
  }

  const JsonPlaceholderApiPhoto(this.id, this.title, this.url, this.albumId);

  static JsonPlaceholderApiPhoto fromJSON(dynamic json) {
    return JsonPlaceholderApiPhoto(
        json["id"], json["title"], json["url"], json["albumId"]);
  }

  @override
  String screenName() {
    return "Photo";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (!kIsWeb)
            ? Image.network(this.url)
            : Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        SizedBox(
          height: 15,
        ),
        KosyText(
          this.title,
          type: TextTypes.header,
        ),
      ],
    );
  }
}
