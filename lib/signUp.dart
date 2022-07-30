// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/loginScreen.dart';
import 'package:flutter_application_2/userModel.dart';
import 'package:flutter_application_2/user_information.dart';
import 'package:fluttertoast/fluttertoast.dart';

class signUp extends StatefulWidget {
  signUp({Key? key}) : super(key: key);

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  final GlobalKey<FormState> formKeys = GlobalKey<FormState>();

  final _name = TextEditingController();
  final _emails = TextEditingController();
  final _newpasswords = TextEditingController();
  final _confirmpasswords = TextEditingController();
  final _uid = TextEditingController();

  final _auth = FirebaseAuth.instance;

  void signUp(
    BuildContext context,
    String emails,
    String passwords,
    String name,
    String uid,
  ) async {
    (formKeys.currentState?.validate());
    await _auth
        .createUserWithEmailAndPassword(
          email: emails,
          password: passwords,
        )
        .then((user) => {
              postDetailsToFirestore(),
              if (user.user != null)
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => usersInformation(
                                email: _emails.text,
                                name: _name.text,
                              ))),
                }
            })
        .catchError((e) {
      Fluttertoast.showToast(msg: e!.message);
    });
  }

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      setState(() {});
    });
  }

  postDetailsToFirestore() async {
    //calling our firestore
    //calling our usermodel
    //sending these values
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    userModel usermodel = userModel(
      uid: 'uid',
      name: 'name',
      email: 'email',
      confirmpassword: null,
    );

    usermodel.email = user!.email;
    usermodel.uid = user.uid;
    usermodel.name = _name.text;
    usermodel.confirmpassword = _confirmpasswords.text as Stream?;

    var firebaseUser = await FirebaseAuth.instance.currentUser!;
    firebaseFirestore
        .collection('userDatas')
        .doc(firebaseUser.uid)
        .set(usermodel.toMap());
    Fluttertoast.showToast(msg: 'Account Created Successfully');

    // ignore: use_build_context_synchronously
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => usersInformation(
                  email: _emails.text,
                  name: _name.text,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 235, 227, 227),
        leading: const Icon(
          Icons.arrow_back,
          color: Colors.indigo,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 235, 227, 227),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Create Account",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo),
                ),
                Form(
                  key: formKeys,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                          margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          color: Colors.white,
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (email) {
                              _emails.text = email!;
                            },
                            validator: ((email) {
                              if (email!.isEmpty) {
                                return "Please enter email";
                              } else if (!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(email)) {
                                return "Invalid email";
                              }
                              return null;
                            }),
                            decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: Colors.grey,
                                ),
                                labelStyle:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                                labelText: "Email"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          color: Colors.white,
                          child: TextFormField(
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            onSaved: (password) {
                              _newpasswords.text = password!;
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
                                labelText: "New Password"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          color: Colors.white,
                          child: TextFormField(
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            onSaved: (password) {
                              _confirmpasswords.text = password!;
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
                                labelText: "Confirm Password"),
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
                              if (formKeys.currentState!.validate()) {
                                (formKeys.currentState?.save());
                                signUp(
                                  context,
                                  _emails.text,
                                  _confirmpasswords.text,
                                  _name.text,
                                  _newpasswords.text,
                                );
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => usersInformation(
                                              email: _emails.text,
                                              name: _name.text,
                                            )));
                                // }
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'Please enter a valid details');
                              }
                            },
                            color: Colors.blue,
                            child: const Text(
                              "Register",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(30, 20, 20, 25),
                        child: Text(
                          "By registering, you confirm that you accept our Terms of Use and Privacy policy.",
                          style: TextStyle(color: Colors.grey),
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
                                'Have An Account?',
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
                                      builder: (context) => loginScreen()));
                            },
                            child: const Text(
                              'Sign In',
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
