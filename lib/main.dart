import 'package:chat_route/auth/home/home_screen.dart';
import 'package:chat_route/my_theme.dart';
import 'package:chat_route/auth/Login/Login_screen.dart';
import 'package:chat_route/firebase_options.dart';
import 'package:chat_route/auth/Register/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// Import the generated file
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute:LoginScreen.routeName ,
    routes: {
      HomeScreen.routeName :(context) => HomeScreen(),
      LoginScreen.routeName :(context) => LoginScreen(),
      RegisterScreen.routeName : (context) =>  RegisterScreen()
    },
    theme: MyTheme.lightMode,
    );
  }
}