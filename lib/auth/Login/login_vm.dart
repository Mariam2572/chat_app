import 'package:chat_route/auth/Login/login_connector.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  late LoginConnector connector ;
 Future<void> login(String emailAddress,String password) async {
  try {
    connector.showLoading();
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: emailAddress,
    password: password
  );
  connector.hideLoading();
  connector.showMessage('Login Successfully');
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    connector.hideLoading();
    connector.showErrorMessage('No user found for that email.');
    print('====================No user found for that email.');
  } else if (e.code == 'wrong-password') {
    connector.hideLoading();
    connector.showErrorMessage('Wrong password provided for that user.');
    print('Wrong password provided for that user.');
  }
}
 }
 }
