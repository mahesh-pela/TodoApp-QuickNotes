class Todo{
  String? id;
  String? todoText;
  String? todoDescription;
  bool isDone;

  Todo({
    required this.id,
    required this.todoText,
    required this.todoDescription,
    this.isDone = false
});

  static List<Todo> todoList(){
    return[
      Todo(id: '1', todoText: 'Morning Breakfast', todoDescription: 'Breakfast done', isDone: true),
      Todo(id: '2', todoText: 'Assignment ',todoDescription: 'Breakfast done', isDone: true),
      Todo(id: '3', todoText: 'Exercise', todoDescription: 'Breakfast done'),
      Todo(id: '4', todoText: 'Buy Groceries', todoDescription: 'Breakfast done'),
      Todo(id: '5', todoText: 'Check Emails', todoDescription: 'Breakfast done'),
      Todo(id: '6', todoText: 'Team Meetings',todoDescription: 'Breakfast done', isDone: true),
    ];
  }

}