import 'package:easy2cook/constants.dart';
import 'package:easy2cook/services/auth.dart';
import 'package:flutter/material.dart';

import '../../shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();

  // global key to track state of our form and help validate it
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.green[400],
              // odstrani DropShadow
              elevation: 0.0,
              title: Text("Sign up to easy2cook :)"),
              actions: <Widget>[
                ElevatedButton.icon(
                  icon: Icon(Icons.person),
                  label: Text("Sign in"),
                  onPressed: () {
                    widget.toggleView();
                  },
                ),
              ],
            ),
            body: Container(
              // levi in desni isti padding / zgornji in spodnji isti padding
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    TextFormField(
                      // constants -> decoration
                      decoration:
                          textInputDecoration.copyWith(hintText: "E-mail"),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      obscureText: true,
                      decoration:
                          textInputDecoration.copyWith(hintText: "Password"),
                      validator: (val) => val!.length < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        // if valid we can send to firebase
                        if (_formKey.currentState!.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, password);

                          // firebase avtomatsko pregleda če je mail veljaven
                          // če ni dobimo response null
                          if (result == null) {
                            setState(() {
                              error = "Supply a valid email!";
                              loading = false;
                            });
                          }
                        }
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
