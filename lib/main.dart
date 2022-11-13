import 'package:flutter/material.dart';
import 'package:wechat/screens/chat_screen.dart';
import 'package:wechat/screens/registration_screen.dart';
import 'package:wechat/screens/signin_screen.dart';
import 'package:wechat/screens/welcomescreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
final _auth = FirebaseAuth.instance ;
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Massege Me',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      // home: ChatScreen(),
      initialRoute: _auth.currentUser !=null  ? ChatScreen.ScreenRoute :WelcomeScreen.ScreenRoute,
      routes: {
        WelcomeScreen.ScreenRoute : (context) => WelcomeScreen() ,
        SignInScreen.screenRoute : (context) => SignInScreen(),
        RegistrationScreen.ScreenRoute : (context) => RegistrationScreen(),
        ChatScreen.ScreenRoute : (context) => ChatScreen(),
      },
    );
  }
}
