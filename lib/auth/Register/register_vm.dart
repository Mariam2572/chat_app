import 'package:chat_route/Components/firebase_errors.dart';
import 'package:chat_route/auth/Register/connector.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterViewModel extends ChangeNotifier {
  late Connector connector;
  Future<void> register(String emailAddress, String password) async {
    try {
      //DialogUtils.showLoading(context, 'Loading...');
      // todo: show loading
      connector.showLoading();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      ); // todo: hide loading
      connector.hideLoading();
      // // todo: show message
      connector.showMessage('Register Successfully');
      print('Register Successfully');
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseFailures.weakPassword) {
        print('The password provided is too weak.');
        // TODO: hide loading
        connector.hideLoading();
        // DialogUtils.hideLoading(context);
        // // todo: show message
        connector.showMessage('The password provided is too weak.');
        // DialogUtils.showMessage(
        //   context: context,
        //   message: 'The password provided is too weak.',
        // );
        connector.showMessage('The password provided is too weak.');
      } else if (e.code == FirebaseFailures.emailInUse) {
        // todo: hide loading
        connector.hideLoading();
        // DialogUtils.hideLoading(context);
        // // todo: show message
        connector.showMessage(FirebaseFailures.emailInUse);
        // DialogUtils.showMessage(
        //   context: context,
        //   message: 'The account already exists for that email',
        // );
        // print('The account already exists for that email.');
      }
    } catch (e) {
      // todo: hide loading
      connector.hideLoading();
      // DialogUtils.hideLoading(context);
      // // todo: show message
      // DialogUtils.showMessage(
      //   context: context,
      //   title: "Error",
      //   message: '${e.toString()}',
      // );
      connector.showMessage('Something went wrong');
      print(e);
    }
  }
}
