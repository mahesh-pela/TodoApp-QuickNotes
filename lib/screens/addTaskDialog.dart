import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Addtaskdialog extends StatefulWidget {
  final Function(String,String) onToDoAdded;
  const Addtaskdialog({super.key, required this.onToDoAdded});

  State<Addtaskdialog> createState() => _Addtaskdialog();
}

class _Addtaskdialog extends State<Addtaskdialog> {

  TextEditingController title_Controller = TextEditingController();
  TextEditingController description_Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add New Todo"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
              style: TextStyle(fontSize: 14),
              controller: title_Controller,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10
                ),
                hintText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12)
                ),
                icon: const Icon(
                  CupertinoIcons.square_list,
                )
              ),
          ),

          SizedBox(
            height: 15
          ),

          TextField(
            style: TextStyle(fontSize: 14),
            controller: description_Controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10
              ),
              hintText: 'Description',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15)
              ),
              icon: const Icon(
                CupertinoIcons.bubble_left_bubble_right,
              )
            ),
          ),
        ],
      ),

    // actions aligns the buttons on the bottom of the dialog box automatically
      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text('Cancel')),

        ElevatedButton(onPressed: (){
          String title = title_Controller.text.trim();
          String description = description_Controller.text.trim();

          if(title.isNotEmpty){
            widget.onToDoAdded(title, description);
          }
        },
          child: Text('Save'),
        )

      ],
    );


  }
}
