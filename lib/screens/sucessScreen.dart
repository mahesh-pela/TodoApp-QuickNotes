import 'package:flutter/material.dart';

import 'login.dart';

class Sucessscreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      // backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              Center(
                child: Container(
                  // color: Colors.blue,
                  width: 300,
                  height: 270,
                  child: Image.asset('assets/images/men-success-laptop-relieve-work-from-home-computer-great.png'),
                ),
              ),
              Text('Congratulations!', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900),),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text("We've sent you a reset email, please check your inbox and follow the instruction to reset your password.", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black54),),
              ),
              SizedBox(height: 20,),
              Center(
                child: Container(
                  width: double.infinity,
                  // padding: EdgeInsets.only(right: 30),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Login()));
                    },
                    child: Text(
                      'Back to Login',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
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
