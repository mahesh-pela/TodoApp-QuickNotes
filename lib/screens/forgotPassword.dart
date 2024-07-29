import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/screens/sucessScreen.dart';

class Forgotpassword extends StatefulWidget {
  @override
  State<Forgotpassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<Forgotpassword> {
  final TextEditingController resetEmailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> resetPassword() async {
    final email = resetEmailController.text.trim();
    print('Resetting password for email: $email');

    try {
      // Check if the user exists
      final signInMethods = await _auth.fetchSignInMethodsForEmail(email);
      print('Sign-in methods for $email: $signInMethods');

      if (signInMethods.isEmpty) {
        print('No user found with this email.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("No user found with this email."),
          ),
        );
        return; // Exit the method if no user is found
      }

      // If user exists, send the password reset email
      await _auth.sendPasswordResetEmail(email: email);
      print('Password reset email sent.');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password reset email sent"),
        ),
      );
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.code}');
      String message;
      switch (e.code) {
        case 'invalid-email':
          message = "The email address is not valid.";
          break;
        case 'user-not-found':
          message = "No user found with this email.";
          break;
        default:
          message = "An error occurred. Please try again.";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $message"),
        ),
      );
    } catch (e) {
      print('Exception: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("An error occurred"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
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
                Text(
                  'Forgot Your Password',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 27),
                ),
                SizedBox(height: 5),
                Text(
                  'If you forgot your password, kindly enter your email below to restore the password',
                  style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black54, fontSize: 15),
                ),
                SizedBox(height: 30),
                Text(
                  'Email Address',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
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
                    onPressed: resetPassword,
                    child: Text(
                      'Reset Password',
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
      ),
    );
  }
}


