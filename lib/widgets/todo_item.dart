import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';

class TodoItem extends StatelessWidget {
  final String Title;
  final String Description;
  final String DateTime;

  TodoItem({
    required this.Title,
    required this.Description,
    required this.DateTime,
  });

  @override
  Widget build(BuildContext context) {
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
                  Title,
                  style: TextStyle(
                    fontSize: 16,
                    color: tdBlack,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  Description,
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
                  DateTime,
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
  }
}
