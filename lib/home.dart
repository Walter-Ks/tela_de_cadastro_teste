import 'dart:convert';
import 'package:aula_01/models/user_models.dart';
import 'package:aula_01/values/preferences.dart';
import 'package:async_extension/async_extension.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:aula_01/paginaCadastro.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color topColor = Colors.blue;
  Color bottomColor = Colors.lightBlueAccent;

  final TextEditingController _mailInputController = TextEditingController();
  TextEditingController get _passwordInputController => TextEditingController();

  bool checkBox = false;

  get json => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              topColor,
              Colors.indigo,
              bottomColor,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Image.asset("assets/logoOnePiece.png", height: 200),
              ),
              const Text(
                "Entrar",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _mailInputController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        labelText: "E-mail",
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon:
                            Icon(Icons.mail_outline, color: Colors.white),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _passwordInputController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Senha",
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.vpn_key, color: Colors.white),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  "Esqueceu a senha?",
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              Row(
                children: [
                  Checkbox(
                    value: checkBox,
                    onChanged: (bool? newValue) {
                      setState(() {
                        checkBox = newValue!;
                      });
                    },
                    activeColor: Colors.blue,
                  ),
                  const Text("Continuar conectado?",
                      style: TextStyle(
                        color: Colors.white,
                      ))
                ],
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 05)),
              // ignore: deprecated_member_use
              RaisedButton(
                onPressed: () {
                  _doLogin();
                },
                child:
                    const Text("Login", style: TextStyle(color: Colors.white)),
                color: Colors.blueAccent[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 05)),
              const Divider(
                color: Colors.black,
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              const Text(
                "Ainda não tem conta?",
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                // ignore: deprecated_member_use
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PaginaCadastro()),
                    );
                  },
                  child: const Text("Cadastre-se",
                      style: TextStyle(color: Colors.black)),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _doLogin() async {
    String mailForm = _mailInputController.toString();
    String passWordForm = _passwordInputController.toString();

    User savedUser = await _getSavedUser();

    if (mailForm == savedUser.mail && passWordForm == savedUser.password) {
      // ignore: avoid_print
      print("deu certo");
    } else {
      // ignore: avoid_print
      print("num deu");
    }
  }

  Future<User> _getSavedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonUser = prefs.getString(
      Preferences.activeUser,
    );
    // ignore: avoid_print
    print(jsonUser);

    User user = User.fromJson(jsonDecode(jsonUser!));
    return user;
  }
}
