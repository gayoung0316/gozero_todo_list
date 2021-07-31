import 'package:flutter/material.dart';
import 'package:todo_list/database/todo.dart';

class ToDoListProvider with ChangeNotifier {
  int _colorSelect = 0;
  int get colorSelect => _colorSelect;
  set colorSelect(int value) {
    _colorSelect = value;
    notifyListeners();
  }

  int _priority = 0;
  int get priority => _priority;
  set priority(int value) {
    _priority = value;
    notifyListeners();
  }

  List<ToDo> _toDoList = [];
  List<ToDo> get toDoList => _toDoList;
  set toDoList(List<ToDo> value) {
    _toDoList = value;
    notifyListeners();
  }

  int _toDoListIdx = 0;
  int get toDoListIdx => _toDoListIdx;
  set toDoListIdx(int value) {
    _toDoListIdx = value;
    notifyListeners();
  }
}
