import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/constants/colors.dart';
import 'package:to_do_app/model/todo.dart';

class TodoItem extends StatefulWidget {
  final Todo todo;  // Add this line
  final Function(Todo) onToDoChange;
  final Function(String) onDeleteItem;

  TodoItem({
    required this.todo,  // Add this line
    required this.onToDoChange,
    required this.onDeleteItem,
    super.key,
  });

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  var time = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No Todos Found'));
          } else {
            return ListView(
              children: snapshot.data!.docs.map((document) {
                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                Todo todo = Todo(
                  id: document.id,
                  todoText: data['title'],
                  todoDescription: data['description'],
                  isDone: data['isDone'] ?? false, // Assuming you have this field
                );

                return Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: ListTile(
                    onTap: () {
                      widget.onToDoChange(todo);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    tileColor: Colors.white,
                    leading: Icon(
                      todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
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
                              todo.todoText ?? '',
                              style: TextStyle(
                                fontSize: 16,
                                color: tdBlack,
                                fontWeight: FontWeight.bold,
                                decoration: todo.isDone ? TextDecoration.lineThrough : null,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              todo.todoDescription ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: tdBlack,
                              ),
                            ),
                            Text(
                              '${time.hour}:${time.minute}',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: tdBlack),
                            ),
                          ],
                        ),
                      ),
                    ),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'delete') {
                          widget.onDeleteItem(todo.id!);
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
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
