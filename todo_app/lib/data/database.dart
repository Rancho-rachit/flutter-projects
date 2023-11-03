import 'package:hive_flutter/adapters.dart';

class ToDoDataBase {
  List toDoList = [];

  // reference the box
  final _mybox = Hive.box('mybox');

  // run this method if this is the 1st time ever opening this app.

  void createInitialData() {
    toDoList = [
      ["Excersice", false],
      ["Study", false]
    ];
  }

  //load the data from databse
  void loadData() {
    toDoList = _mybox.get("TODOLIST");
  }

  //update the databse
  void updateDataBase() {
    _mybox.put("TODOLIST", toDoList);
  }
}
