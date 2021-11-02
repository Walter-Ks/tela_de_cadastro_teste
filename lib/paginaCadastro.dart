// ignore_for_file: file_names

import 'dart:convert';
import 'package:aula_01/home.dart';
import 'package:aula_01/values/preferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/user_models.dart';

class PaginaCadastro extends StatefulWidget {
  const PaginaCadastro({Key? key}) : super(key: key);

  @override
  _PaginaCadastroState createState() => _PaginaCadastroState();
}

class _PaginaCadastroState extends State<PaginaCadastro> {
  final TextEditingController _nameInputController = TextEditingController();
  final TextEditingController _mailInputController = TextEditingController();
  final TextEditingController _passwordInputController =
      TextEditingController();
  final TextEditingController _confirmInputController = TextEditingController();

  bool checkMostrarSenha = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.indigo,
              Colors.lightBlueAccent,
              Colors.indigo,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Cadastro",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              Form(
                child: Column(
                  children: [
                    TextField(
                      controller: _nameInputController,
                      cursorColor: Colors.white,
                      autofocus: true,
                      decoration: const InputDecoration(
                        labelText: "Nome",
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.person, color: Colors.white),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 15),
                    ),
                    TextField(
                      controller: _mailInputController,
                      autofocus: true,
                      cursorColor: Colors.white,
                      decoration: const InputDecoration(
                        labelText: "E-mail",
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon:
                            Icon(Icons.mail_outline, color: Colors.white),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 15),
                    ),
                    TextField(
                      controller: _passwordInputController,
                      obscureText: (checkMostrarSenha == true) ? false : true,
                      cursorColor: Colors.white,
                      autofocus: true,
                      decoration: const InputDecoration(
                        labelText: "Senha",
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.vpn_key, color: Colors.white),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 15),
                    ),
                    (checkMostrarSenha == false)
                        ? TextField(
                            controller: _confirmInputController,
                            obscureText: true,
                            cursorColor: Colors.white,
                            autofocus: true,
                            decoration: const InputDecoration(
                              labelText: "Confirme sua senha",
                              labelStyle: TextStyle(color: Colors.white),
                              prefixIcon:
                                  Icon(Icons.vpn_key, color: Colors.white),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                          )
                        : Container(),
                    const Padding(
                      padding: EdgeInsets.only(top: 15),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: checkMostrarSenha,
                          onChanged: (bool? value) {
                            setState(
                              () {
                                checkMostrarSenha = value!;
                              },
                            );
                          },
                          activeColor: Colors.blue,
                        ),
                        const Text(
                          "Mostar a senha?",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15),
              ),
              // ignore: deprecated_member_use
              RaisedButton(
                onPressed: () {
                  _doSignUp();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                child: const Text(
                  "Cadastrar",
                  style: TextStyle(color: Colors.black),
                ),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _doSignUp() {
    User newUser = User(
      name: _nameInputController.text,
      mail: _mailInputController.text,
      password: _passwordInputController.text,
      keepOn: true,
    );
    // ignore: avoid_print
    print(newUser);
    _saveUser(newUser);
  }

  // ignore: unused_element
  void _saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
      Preferences.activeUser,
      json.encode(user.toJson()),
    );
  }
}
