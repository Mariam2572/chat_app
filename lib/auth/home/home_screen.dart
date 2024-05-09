import 'package:flutter/material.dart';

import '../../my_theme.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Stack(
          children: [
            Container(
              color: MyTheme.whiteColor,
              child: Image.asset(
                'assets/images/background.png',
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Scaffold(
              //resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: Text(
                  'Home',
                  style: Theme.of(context).textTheme.titleLarge,),
                  ))
          ]);
  }
}