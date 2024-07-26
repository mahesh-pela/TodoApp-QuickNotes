//this screen consists of the home page

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/constants/colors.dart';
import 'package:to_do_app/screens/TodoScreen.dart';
import 'package:to_do_app/screens/login.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  //google signout
  Future<void> signOutFromGoogle() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      await _googleSignIn.disconnect();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  //Delete todo
  Future<void> deleteToDo(String docId) async{
    try{
      await FirebaseFirestore.instance.collection("Users").doc(docId).delete();
      print("Todo deleted successfully");
    }catch(e){
        print("Error deleting todo");
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
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
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    // .where('userID', isEqualTo: user!.uid)
                    .orderBy('DateTime', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      // code for search query
                      //filter documents based on the search query
                      final filteredDocs = snapshot.data!.docs.where((doc){
                        final title = doc['Title']?.toLowerCase() ?? '';
                        final description = doc['Description']?.toLowerCase() ?? '';
                        return title.contains(_searchQuery) || description.contains(_searchQuery);
                      }).toList();

                      return ListView.builder(
                        itemCount: filteredDocs.length,
                        itemBuilder: (context, index) {
                          final doc = filteredDocs[index];
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
                                        doc["Title"] ?? 'No Title',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: tdBlack,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        doc["Description"] ?? 'No Description',
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
                                        doc["DateTime"] ?? 'No Date',
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
                                  if(value == 'edit'){
                                    Navigator.push(
                                      context, MaterialPageRoute(builder: (context) =>Todoscreen(docId: doc.id)),
                                    );
                                  }
                                  else if (value == 'delete') {
                                    deleteToDo(doc.id);
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
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return Center(child: Text('No Data Found'));
                    }
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )


          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Todoscreen(docId: null)));
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
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
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
              controller: _searchController,
              onChanged: (value){
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
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
