import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/constants/colors.dart';

class Forgotpassword extends StatefulWidget{
  @override
  State<Forgotpassword> createState() => _ForgotPasswordState();

}

class _ForgotPasswordState extends State<Forgotpassword>{

  TextEditingController resetEmailController = TextEditingController();
  //forgot password logic
  final _auth = FirebaseAuth.instance;
  Future<void> sendPasswordResetLink(String email) async{
    try{
      await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
           onPressed: (){
            Navigator.pop(context);
        },),
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Forgot Your Password',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
              SizedBox(height: 5,),
              Text('If you forgot your password, kindly enter your email below to restore the password', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black54, fontSize: 15),),
              SizedBox(height: 30,),
              Text('Email Address', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),
              SizedBox(height: 5,),
              TextField(
                controller: resetEmailController,
               decoration: InputDecoration(
                 contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                 hintText: 'hello@example.com',
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(12),
                 ),
                 hintStyle: TextStyle(color: Colors.grey.shade500)
               ),
              ),
              SizedBox(height: 15,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                width: MediaQuery.of(context).size.width,
                child: Container(
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () async{
                       await sendPasswordResetLink(resetEmailController.text);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Reset email has been successfully sent')));

                      Navigator.pop(context);
                      },
                      child: Text('Submit', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  ),
                ),
              )
            ],
          ),
      ),
    );
  }

}