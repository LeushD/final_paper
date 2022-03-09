import 'package:flutter/material.dart';

import 'main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _login ='', _password='';
  String _message = '';

  void _checkLogin () {
    setState(() {
      if (_login == username.login && _password == username.password) {
        _message = '';
        Navigator.pushNamed(context, '/list');
      } else {
        _message = 'Ошибка авторизации';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const borderStyle = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(36)),
        borderSide: BorderSide(
            color: Color(0xFFeceff1),width: 2));
    const linkTextStyle = TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFFFFFFFF)
    );

    return MaterialApp(
        home: Scaffold(
            body: SingleChildScrollView(
              padding: const EdgeInsets.only(left: 0, right: 0, top: 100),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 110, height: 84,
                      child: Image(image: AssetImage('assets/images/dart-logo.png')),),
                    const SizedBox(height: 20,),
                  Text('Введите имя пользователя и пароль:',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
                    child: TextField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFeceff1),
                          enabledBorder: borderStyle,
                          focusedBorder: borderStyle,
                          labelText: 'Имя пользователя',
                          hintText: username.login
                      ),
                      onChanged: (value) {
                        setState(() {
                          _login = value;
                          _message = '';
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30, top: 10, bottom: 30),
                    child: TextField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFeceff1),
                          enabledBorder: borderStyle,
                          focusedBorder: borderStyle,
                          labelText: 'Пароль',
                          hintText: username.password
                      ),
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                          _message = '';
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(_message),
                  ),
                  Ink(
                    padding: const EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(55),
                      color: Colors.blue,
                    ),
                    child: InkWell(
                      //borderRadius: BorderRadius.circular(55),
                      child: const Text('Вход', style: linkTextStyle,),
                      onTap: () {
                        _checkLogin();
                      },
                    ),
                  ),
                ]
            ),
        ),
      ),
    );
  }
}