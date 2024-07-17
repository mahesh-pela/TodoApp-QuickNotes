import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/constants/colors.dart';
import 'package:to_do_app/model/todo.dart';
import 'package:to_do_app/screens/TodoScreen.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final Function(Todo) onToDoChange;
  final Function(String) onDeleteItem;

  TodoItem({
    required this.todo,
    required this.onToDoChange,
    required this.onDeleteItem,
    super.key,
  });

  var time = DateTime.now();
  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        // onTap: () {
        //   onToDoChange(todo);
        // },
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Todoscreen()));
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
                  todo.todoText!,
                  style: TextStyle(
                    fontSize: 16,
                    color: tdBlack,
                    fontWeight: FontWeight.bold,
                    decoration: todo.isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
                SizedBox(height: 4),
                // Optional spacing between title and description
                Text(
                  todo.todoDescription!,
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
                    color: tdBlack
                  ),
                ),
              ],
            ),
          ),
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'delete') {
              onDeleteItem(todo.id!);
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(value: 'edit', child: Text('Edit')),
              PopupMenuItem<String>(value: 'delete', child: Text('Delete'))
            ];
          },
        ),
      ),
    );
  }
}
