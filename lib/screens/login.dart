// import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/constants/colors.dart';
import 'package:to_do_app/constants/textStyleTheme.dart';
import 'package:to_do_app/screens/home.dart';
import 'package:to_do_app/screens/signUP.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var uemail = TextEditingController();
  var upass = TextEditingController();
  var _obscureText = true;
  FirebaseAuth _auth = FirebaseAuth.instance;


  void _signIn() async{
    try{
      // shows the circular progress when log in
      showDialog(
          context: context,
          builder: (context){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
      );
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: uemail.text,
          password: upass.text
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>Home()));
    }catch(e){
      print('An unexpected error occurred. Please try again later.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 150,
              ),
              RichText(
                text: TextSpan(
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: Colors.black
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Welcome ',
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Colors.red),
                      ),
                      TextSpan(text: 'back 👋')
                    ]),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text('Enter your email',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.only(right: 30),
                child: TextField(
                  controller: uemail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email_rounded),
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    hintText: 'test@gmail.com',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        // Lighter color for less visibility
                        width: 1.0, // Thinner border for less visibility
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text('Enter your password',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: EdgeInsets.only(right: 30),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: TextField(
                  obscureText: _obscureText,
                  controller: upass,
                  decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 15, bottom: 15, right: 10),
                        child: ImageIcon(
                          AssetImage('assets/images/passlock.png'),
                          size: 5,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      hintText: 'Enter your password',
                      suffixIcon: IconButton(
                        icon: Icon(_obscureText
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    'Having Issues? Reset Password now',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0000EE),
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(right: 30),
                child: ElevatedButton(
                  onPressed: () {
                    _signIn();
                  },
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Signup()));
                    },
                    child: Text(
                      " Create Now",
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.red),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  'Or Sign In With',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 150,
                    height: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Colors.grey.shade200, width: 1.5)),
                    child: IconButton(
                      icon: Image.asset('assets/images/google logo.png'),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Colors.grey.shade200, width: 1.5)),
                    child: IconButton(
                      icon: Image.asset('assets/images/facebook logo.png'),
                      onPressed: () {},
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
