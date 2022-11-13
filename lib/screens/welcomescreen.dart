import 'package:flutter/material.dart';
import 'package:wechat/screens/registration_screen.dart';
import 'package:wechat/screens/signin_screen.dart';
import 'package:wechat/widgets/my_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String ScreenRoute = 'welcome_screen' ;

  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // backgroundColor: Color.fromARGB(255, 248, 245, 245),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Container(
                    height: 300,
                    child: Image.asset("images/1.jpg"),
                  ),
                  Text(
                    "We Chat",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Colors.teal[700],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              MyButton(
                onPressed: () {
                  Navigator.pushNamed(context, SignInScreen.screenRoute);
                },
                color: Colors.teal[700]!,
                title: "Sign In",
              ),
              MyButton(
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.ScreenRoute);
                },
                color: Colors.blue[900]!,
                title: "Register",
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Developed by',style: TextStyle(color: Colors.black45)),
                  Text(';{هشام كمال الحداد};',style: TextStyle(color: Colors.black)),
                ],
              )
            ]
        ),
      ),
    );
  }
}
