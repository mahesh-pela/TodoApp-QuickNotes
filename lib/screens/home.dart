import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/model/todo.dart';
import 'package:to_do_app/screens/addTaskDialog.dart';
import '../constants/colors.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = Todo.todoList();
  final todoController = TextEditingController();
  List<Todo> foundToDo = [];

  @override
  void initState() {
    foundToDo = todosList;
    super.initState();
  }

  void _onLogout(BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logged Out')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: buildAppBar(),
      body: dashboard(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Addtaskdialog(
                onToDoAdded: (title, description) {
                  addToDoItem(title, description);
                  Navigator.of(context).pop();
                },
              );
            },
          );
        },
        backgroundColor: Colors.blue.shade800,
        child: Icon(
          CupertinoIcons.add,
          size: 35,
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void handleToDoChange(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void addToDoItem(String toDoText, String todoDescription) {
    setState(() {
      todosList.add(Todo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: toDoText,
          todoDescription: todoDescription));
      todoController.clear();
    });
  }

  void runFilter(String searchKeyword) {
    List<Todo> results = [];
    if (searchKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) =>
          item.todoText!.toLowerCase().contains(searchKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundToDo = results;
    });
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: tdBGColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: tdGrey,
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'settings') {
                // Handle settings action
              } else if (value == 'logout') {

              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'settings',
                  child: Row(
                    children: [
                      Icon(Icons.settings),
                      SizedBox(width: 10),
                      Text('Settings'),
                    ],
                  ),
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
          ),
        ],
      ),
    );
  }

  Container dashboard() {
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
              onChanged: (value) => runFilter(value),
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
          Expanded(
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 40, bottom: 20),
                  child: Text(
                    'All ToDos',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                for (Todo todoo in foundToDo.reversed)
                  TodoItem(
                    todo: todoo,
                    onToDoChange: handleToDoChange,
                    onDeleteItem: deleteToDoItem,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
