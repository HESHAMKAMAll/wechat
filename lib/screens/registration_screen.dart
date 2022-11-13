import 'package:flutter/material.dart';
import 'package:wechat/screens/chat_screen.dart';
import 'package:wechat/widgets/my_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static const String ScreenRoute = 'registration_screen' ;
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance ;
  

  late String email ;
  late String password ;

  bool showSpinner = false ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    child: Image.asset("images/6.jpg"),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value ;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Enter Your Email',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue[700]!, width: 3),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value ;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Your Password',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue[700]!, width: 3),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MyButton(
                      color: Colors.blue[800]!,
                      title: 'Register',
                      onPressed: () async {
                        try{
                          final newUser = await _auth.createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );

                          Navigator.pushNamed(context, ChatScreen.ScreenRoute) ;

                          setState(() {
                            showSpinner = false ;
                          });
                        } catch (e){
                          print(e);
                        }



                        setState(() {
                          showSpinner = true ;
                        });
                        // print(email);
                        // print(password);
                      },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('هشام',style: TextStyle(color: Colors.black45)),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
