//this is screen for adding the todo

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Todoscreen extends StatefulWidget {

  const Todoscreen({Key? key}) : super(key: key);

  @override
  State<Todoscreen> createState() => _TodoscreenState();
}

class _TodoscreenState extends State<Todoscreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  var currentDateTime = DateTime.now();
  OverlayEntry? _popupMenuOverlay;

  String getFormattedDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy hh:mm a');
    return formatter.format(dateTime);
  }

  //adding data to the firebase
  void addData(String title, String description, String datetime) async{
    // to get the current userId
    final user = FirebaseAuth.instance.currentUser;
    if(title.isNotEmpty){
      FirebaseFirestore.instance.collection("Users").doc().set({
        "Title" : title,
        "Description" : description,
        "DateTime" : datetime,
        "userID" : user!.uid,
      }).then((value){
          print('Data Inserted');
      });
    }
  }

  void _onMenuItemSelected(String value) {
    switch (value) {
      case 'save':
        String usrtitle = titleController.text.trim();
        String usrdescription = descriptionController.text.trim();
        String formattedDateTime = getFormattedDateTime(currentDateTime);

        addData(usrtitle, usrdescription, formattedDateTime);

        Navigator.pop(context);
        break;
      case 'reminder':
      // Handle reminder action
        break;
      case 'cancel':
        Navigator.pop(context); // Close Todoscreen
        break;
      case 'delete':
      // Handle delete action
        break;
    }
    _popupMenuOverlay?.remove(); // Remove overlay after handling action
    FocusScope.of(context).requestFocus(FocusNode()); // Remove focus from text fields
  }

  void _showPopupMenu(BuildContext context) {
    final RenderBox overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;

    _popupMenuOverlay = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Dim the background
          GestureDetector(
            onTap: () {
              _popupMenuOverlay?.remove();
            },
            child: Container(
              color: Colors.black54,
            ),
          ),
          // Popup menu
          Positioned(
            right: 20,
            top: AppBar().preferredSize.height + 30,
            child: Material(
              color: Colors.transparent, // Make the Material widget transparent
              child: Container(
                width: 150,
                padding: EdgeInsets.all(8.0), // Add padding here
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: Colors.white, // Background color for the container
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 20,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => _onMenuItemSelected('save'),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Save',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _onMenuItemSelected('reminder'),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Reminder',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _onMenuItemSelected('cancel'),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Cancel',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _onMenuItemSelected('delete'),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Delete',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context)!.insert(_popupMenuOverlay!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () => _showPopupMenu(context),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            // Title
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 20, bottom: 10),
                hintText: 'Title',
                hintStyle: TextStyle(
                  color: Colors.black26,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
              minLines: 1,
              maxLines: null,
            ),
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  '${currentDateTime.day}/${currentDateTime.month}/${currentDateTime.year} ${currentDateTime.hour}:${currentDateTime.minute}',
                  style: TextStyle(color: Colors.black45, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  hintText: 'Start typing',
                  hintStyle: TextStyle(fontSize: 18, color: Colors.black26),
                  border: InputBorder.none),
              minLines: 1,
              maxLines: null,
            )
          ],
        ),
      ),
    );
  }
}
