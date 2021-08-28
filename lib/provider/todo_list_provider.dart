import 'package:flutter/material.dart';
import 'package:todo_list/model/todo.dart';

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

  List<ToDo> _completeToDoList = [];
  List<ToDo> get completeToDoList => _completeToDoList;
  set completeToDoList(List<ToDo> value) {
    _completeToDoList = value;
    notifyListeners();
  }

  String _toDoListIdx = '';
  String get toDoListIdx => _toDoListIdx;
  set toDoListIdx(String value) {
    _toDoListIdx = value;
    notifyListeners();
  }

  String _completeTitle = '';
  String get completeTitle => _completeTitle;
  set completeTitle(String value) {
    _completeTitle = value;
    notifyListeners();
  }

  int _completePriority = 0;
  int get completePriority => _completePriority;
  set completePriority(int value) {
    _completePriority = value;
    notifyListeners();
  }

  int _completeColor = 0;
  int get completeColor => _completeColor;
  set completeColor(int value) {
    _completeColor = value;
    notifyListeners();
  }

  String _completeDate = '';
  String get completeDate => _completeDate;
  set completeDate(String value) {
    _completeDate = value;
    notifyListeners();
  }

  bool _backgroundColorChoice = false;
  bool get backgroundColorChoice => _backgroundColorChoice;
  set backgroundColorChoice(bool value) {
    _backgroundColorChoice = value;
    notifyListeners();
  }

  int _backgroundColor = 0;
  int get backgroundColor => _backgroundColor;
  set backgroundColor(int value) {
    _backgroundColor = value;
    notifyListeners();
  }

  String _todayDate = '';
  String get todayDate => _todayDate;
  set todayDate(String value) {
    _todayDate = value;
    notifyListeners();
  }

  TextEditingController _textEditingController = TextEditingController();
  get textEditingController => _textEditingController;
}
