import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:to_do_app/constants/colors.dart';
import 'package:to_do_app/screens/login.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  //google signout
  Future<void> signOutFromGoogle() async{
    try{
      await _auth.signOut();
      await _googleSignIn.signOut();
      await _googleSignIn.disconnect();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Login()));
    }catch(e){
      print('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            searchBox(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('All Todos', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28, ),),
            ),
            SizedBox(height: 10),
            Expanded(
              //fetching data form the firestore
              child: StreamBuilder(
                //location where data is stored in the firestore
                stream: FirebaseFirestore.instance.collection("Users").snapshots(),
                builder: (context, snapshot){
                  //checking whether the connection with firebase is succeded or not
                  if(snapshot.connectionState == ConnectionState.active){
                    // retrieving the data
                    if(snapshot.hasData){
                      return ListView.builder(itemBuilder: (context,index){
                        return Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            tileColor: Colors.white,
                            leading: Icon(
                              Icons.check_box_outline_blank,
                              color: tdBlue,
                            ),
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${snapshot.data!.docs[index]["Title"]}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: tdBlack,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '${snapshot.data!.docs[index]["Description"]}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: tdBlack,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '${snapshot.data!.docs[index]["DateTime"]}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            trailing: PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == 'delete') {
                                  // Handle delete action
                                }
                              },
                              itemBuilder: (BuildContext context) {
                                return [
                                  PopupMenuItem<String>(value: 'edit', child: Text('Edit')),
                                  PopupMenuItem<String>(value: 'delete', child: Text('Delete')),
                                ];
                              },
                            ),
                          ),
                        );
                      },
                        itemCount: snapshot.data!.docs.length,
                      );
                    }
                    else if(snapshot.hasError){
                      return Center(child: Text('${snapshot.hasError.toString()}'),);
                    }
                    else{
                      return Center(child: Text('No Data Found'),);
                    }
                  }
                  else{
                    return Center(child: CircularProgressIndicator(),);
                  }

                }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        backgroundColor: Colors.orange,
        child: Icon(
          CupertinoIcons.add,
          size: 30,
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),

    );
  }
  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: tdBGColor,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: tdGrey,
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                signOutFromGoogle();
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'email',
                  child: Text('${FirebaseAuth.instance.currentUser?.email ?? 'Unknown'}'),
                ),
                PopupMenuItem<String>(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(Icons.logout),
                      SizedBox(width: 10),
                      Text('Logout'),
                    ],
                  ),
                ),
              ];
            },
            icon: CircleAvatar(
              backgroundImage: AssetImage('assets/images/mahesh.jpg'),
              radius: 18,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13)
            ),
            color: Colors.white,
            elevation: 4,
            offset: Offset(0,50),
          ),
        ],
      ),
    );
  }
  Container searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: tdBlack,
                  size: 20,
                ),
                hintText: 'Search',
                prefixIconConstraints: BoxConstraints(
                  maxHeight: 20,
                  minWidth: 25,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
