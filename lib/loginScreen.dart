// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/main.dart';
import 'package:flutter_application_2/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_2/user_information.dart';
import 'package:fluttertoast/fluttertoast.dart';

class loginScreen extends StatefulWidget {
  loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

// ignore: camel_case_types
class _loginScreenState extends State<loginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _passwords = TextEditingController();

  void signIn(BuildContext context) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _name.toString(), password: _passwords.toString())
        .then((authUser) {
      if (authUser.user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => signUp()));
      }
    }).catchError((e) {
      Fluttertoast.showToast(msg: e!.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 227, 227),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('images/download.png'),
                ),
                const Text(
                  "Creativa",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 1, 26, 46)),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: Container(
                          margin: const EdgeInsets.all(18),
                          color: Colors.white,
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            controller: _name,
                            onSaved: (name) {
                              _name.text = name!;
                            },
                            validator: ((name) {
                              if (name!.isEmpty) {
                                return "Please enter name";
                              } else if (name.length < 2 && name.length > 15) {
                                return "its not valid name";
                              }
                              return null;
                            }),
                            decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.account_box_outlined,
                                  color: Colors.grey,
                                ),
                                labelStyle:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                                labelText: "User Name"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(18, 10, 18, 10),
                          color: Colors.white,
                          child: TextFormField(
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            controller: _passwords,
                            onSaved: (password) {
                              _passwords.text = password!;
                            },
                            validator: (password) {
                              if (password!.isEmpty) {
                                return "Please enter a password";
                              } else if (password.length < 8 ||
                                  password.length > 12) {
                                return "please enter between 8 to 12 characters";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock_open_outlined,
                                  color: Colors.grey,
                                ),
                                labelStyle:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                                labelText: "Password"),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 20, left: 20, top: 25),
                        child: Container(
                          height: 50,
                          width: 340,
                          child: RaisedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                (formKey.currentState?.save());
                                signIn(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => signUp()));
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'Please Fill the User Data');
                              }
                            },
                            color: Colors.blue,
                            child: const Text(
                              "Sign in",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          primary: const Color.fromARGB(255, 250, 251, 252),
                        ),
                        onPressed: () {},
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          child: Text(
                            'Forget Password?',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 340,
                        color: Color.fromARGB(255, 138, 165, 212),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Icon(
                              Icons.facebook,
                              color: Colors.indigo,
                            ),
                            Text(
                              "Sign in with Facebook",
                              style: TextStyle(color: Colors.indigo),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          height: 50,
                          width: 340,
                          color: Color.fromARGB(255, 197, 131, 126),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Icon(
                                Icons.report_gmailerrorred_sharp,
                                color: Colors.red,
                              ),
                              Text(
                                "Sign in with Google",
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              child: const Text(
                                'Dont Have An Account?',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              primary: const Color.fromARGB(255, 250, 251, 252),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => signUp()));
                            },
                            child: const Text(
                              'Create One',
                              style: TextStyle(
                                  color: Colors.indigo,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
