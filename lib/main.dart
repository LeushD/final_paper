import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'UserLogin.dart';
import 'Theme.dart';
import 'UserInfo.dart';
import 'List.dart';

void main() {
  runApp(const MyApp());
}

User ? currentUser;
var currentIndex = 0;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: globalTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/list': (context) => const ListScreen(),
        '/user': (context) => const UserScreen(),
      },
    );
  }
}

class LoginUser{
  String login, password;

  LoginUser({
    required this.login,
    required this.password
  });
}

class Geo {
  final String lat, lng;

  Geo({
    required this.lat,
    required this.lng
  });

}

class Address {
  final String street, suite, city, zipcode;
  final Geo geo;

  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

}

class Company {
  final String name, catchPhrase, bs;

  Company({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

}

class User {
  final int id;
  final String name, username, email;
  final Address address;
  final String phone, website;
  final Company company;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      address: Address(
        street: json['address']['street'],
        suite: json['address']['suite'],
        city: json['address']['city'],
        zipcode: json['address']['zipcode'],
        geo: Geo(
          lat: json['address']['geo']['lat'],
          lng: json['address']['geo']['lng'],
        ),
      ),
      phone: json['phone'],
      website: json['website'],
      company: Company(
          name: json['company']['name'],
          catchPhrase: json['company']['catchPhrase'],
          bs: json['company']['bs']
      ),

    );
  }
}

class UserTask {
  int userId, id;
  String title;
  bool completed;

  UserTask({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed
  });

  factory UserTask.fromJson(Map<String, dynamic> json) {
    return UserTask(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        completed: json['completed']
    );
  }

}


Future<User> fetchUser() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users/1'));

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Не удалось получить данные');
  }
}

Future<List<User>> fetchUserList() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

  if (response.statusCode == 200) {
    return compute(parseUsers, response.body);
  } else {
    throw Exception('Не удалось получить данные');
  }
}

List<User> parseUsers(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<User>((json) => User.fromJson(json)).toList();
}

Future<List<UserTask>> fetchUserTaskList(int id) async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos?userId=$id'));

  if (response.statusCode == 200) {
    return compute(parseUserTaskList, response.body);
  } else {
    throw Exception('Не удалось получить данные!');
  }
}

List<UserTask> parseUserTaskList(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<UserTask>((json) => UserTask.fromJson(json)).toList();
}

final LoginUser username = LoginUser(login: 'username', password: '12345');

final myListTileShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(15),
  side: BorderSide(color: globalTheme().primaryColor),
);

Widget AppDrawer(context) => Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      DrawerHeader(
          decoration: const BoxDecoration(
              color: Colors.blue
          ),
          child: Container(
            height: 200,
          )
      ),
      ListTile(
        leading: const Icon(Icons.home, color: Colors.blueGrey),
        title: const Text('Главная'),
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/');
        },
      ),
      ListTile(
        leading: const Icon(Icons.list, color: Colors.blueGrey),
        title: const Text('Список'),
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/list');
        },
      ),
      ListTile(
        leading: const Icon(Icons.info, color: Colors.blueGrey),
        title: const Text('Инфо'),
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/user');
        },
      )
    ],
  ),
);
