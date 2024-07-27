import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/screens/sucessScreen.dart';

class Forgotpassword extends StatefulWidget {
  @override
  State<Forgotpassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<Forgotpassword> {
  TextEditingController resetEmailController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  // Forgot password logic
  Future<void> sendPasswordResetLink(String email) async {
    try {
      // Fetch sign-in methods for the provided email
      List<String> signInMethods = await _auth.fetchSignInMethodsForEmail(email);
      if (signInMethods.isEmpty) {
        // No user with this email exists
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No user found with this email.')),
        );
      } else {
        // Email exists, send password reset email
        await _auth.sendPasswordResetEmail(email: email);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Reset email sent successfully')),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Sucessscreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: ${e.message}")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred")),
      );
    }
  }

  // Validate email and send reset link
  void validateAndSendEmail() async {
    final email = resetEmailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your email')),
      );
    } else {
      await sendPasswordResetLink(email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 300,
                height: 250,
                child: Image.asset('assets/images/forgot-password-concept-illustration.png'),
              ),
              Text('Forgot Your Password', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 27)),
              SizedBox(height: 5),
              Text(
                'If you forgot your password, kindly enter your email below to restore the password',
                style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black54, fontSize: 15),
              ),
              SizedBox(height: 30),
              Text('Email Address', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
              SizedBox(height: 5),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: TextField(
                  controller: resetEmailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email_rounded),
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    hintText: 'hello@example.com',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    validateAndSendEmail();
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
