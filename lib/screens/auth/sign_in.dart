import 'package:easy2cook/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:easy2cook/constants.dart';
import 'package:easy2cook/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // textfield state
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
              automaticallyImplyLeading: false,
              backgroundColor: Colors.green[400],
              // odstrani DropShadow
              elevation: 0.0,
              title: Text("Login:"),
              actions: <Widget>[
                ElevatedButton.icon(
                  icon: Icon(Icons.person),
                  label: Text("Register"),
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
                      decoration:
                          textInputDecoration.copyWith(hintText: "E-mail"),
                      validator: (val) =>
                          val!.isEmpty ? "Enter an email" : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: "Password"),
                      obscureText: true,
                      validator: (val) => val!.length < 6
                          ? "Enter a password 6+ chars long"
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
                          // loading ...
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);
                          // firebase avtomatsko pregleda če je mail veljaven
                          // če ni dobimo response null
                          if (result == null) {
                            setState(() {
                              error = "No user with those credentials!";
                              loading = false;
                            });
                          }
                        }
                      },
                      child: Text(
                        "Sign in",
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
