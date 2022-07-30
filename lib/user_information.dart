import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_2/user_information.dart';
import 'package:flutter_application_2/loginScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class usersInformation extends StatelessWidget {
  late String name, email;

  usersInformation({required this.email, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: Column(
          children: [
            Text(
              'Name: $name',
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text('Email: $email',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
