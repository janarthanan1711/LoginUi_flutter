import 'package:flutter_application_2/signUp.dart';

// ignore: camel_case_types
class userModel {
  String? uid;
  String? name;
  String? email;
  Stream? confirmpassword;

  userModel(
      {required this.uid,
      required this.name,
      required this.email,
      required this.confirmpassword});

//receiving data from server

  factory userModel.fromMap(map) {
    return userModel(
        uid: map['uid'],
        name: map['name'],
        email: map['email'],
        confirmpassword: map['confirmpassword']);
  }

//sending data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'confirmpassword': confirmpassword
    };
  }
}
