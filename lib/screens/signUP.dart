import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/screens/login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var uemail = TextEditingController();
  var upass = TextEditingController();
  var _obscureText = true;
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
              SizedBox(
                height: 120,
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 32, fontWeight: FontWeight.w700, color: Colors.red
                  ),
                  children: <TextSpan>[
                    TextSpan(text: 'Welcome '),
                    TextSpan(text: 'to QuickNotes 👋', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600, color: Colors.black))
                  ]
                ),
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w500,color: Colors.black
                  ),
                  children: <TextSpan>[
                    TextSpan(text: "Let's turn your "),
                    TextSpan(text: 'Plans ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.red)),
                    TextSpan(text: 'into '),
                    TextSpan(text: 'Achivements', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.red))

                  ]
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text('Full Name',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),

              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.only(right: 30),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter your name',
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300, // Lighter color for less visibility
                        width: 1.0, // Thinner border for less visibility
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text('Email address',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                        color: Colors.grey.shade300, // Lighter color for less visibility
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
                child: Text('Password',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: EdgeInsets.only(right: 30),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(20)),
                child: TextField(
                  obscureText: _obscureText,
                  controller: upass,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ImageIcon(
                          AssetImage('assets/images/passlock.png'),
                        size: 5,
                      ),
                    ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      hintText: 'Enter your password',
                      suffixIcon: IconButton(
                        icon: Icon(
                            _obscureText?Icons.visibility_off: Icons.visibility),
                        onPressed: (){
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
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(right: 30),
                child: ElevatedButton(
                  onPressed: () {
                    //sign up logic
                    final auth = FirebaseAuth.instance;
                    auth.createUserWithEmailAndPassword(
                        email: uemail.text,
                        password: upass.text
                    );
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => Login()));
                  },

                  child: Text(
                    'Sign Up',
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
                    "Already have an account? ",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(
                        context, MaterialPageRoute(builder: (context) => Login())
                      );
                    },
                    child: Text(
                      "Sign In",
                      style:
                      TextStyle(fontWeight: FontWeight.w700, color: Colors.red),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Center(
                child: Text(
                  'Or Sign Up With',
                  style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 150,
                    height: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Colors.grey.shade200,
                            width: 1.5
                        )
                    ),
                    child: IconButton(
                      icon: Image.asset('assets/images/google logo.png'),
                      onPressed: (){},
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Colors.grey.shade200,
                            width: 1.5
                        )
                    ),
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

