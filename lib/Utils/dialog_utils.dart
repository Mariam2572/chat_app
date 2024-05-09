import 'package:chat_route/my_theme.dart';
import 'package:flutter/material.dart';

class DialogUtils{
  static void showMessage(
      {required BuildContext context,
      required String message,
      String? title,
      String? posActionName,
      Function? posAction,
      String? negActionName,
      Function? negAction}) {
    List<Widget> actins = [];
    if (posActionName != null) {
      actins.add(ElevatedButton(
          onPressed: () {
            if (posAction != null) {
              posAction.call();
            }
           //Navigator.pop(context);
          },
          child: Text(posActionName,style: TextStyle(color:MyTheme.primary),)));
    }
    if (negActionName != null) {
      actins.add(ElevatedButton(
          onPressed: () {
            if (negAction != null) {
              negAction.call();
            }
            Navigator.pop(context);
          },
          child: Text(negActionName)));
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(25)),
          content: Text(message,style: TextStyle(color:Colors.black),),
          title: Text(title ?? '',style: TextStyle(
            color: MyTheme.blackLight
          ),),
          actions: actins,
        );
      },
    );
  }

}