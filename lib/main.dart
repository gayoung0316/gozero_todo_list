import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_list/main_home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => MaterialApp(
        title: 'ToDo List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'SeoulNamsan',
        ),
        home: MainToDoListPage(),
      ),
    );
  }
}

class MainToDoListPage extends StatefulWidget {
  MainToDoListPage({Key? key}) : super(key: key);
  @override
  _MainToDoListPageState createState() => _MainToDoListPageState();
}

class _MainToDoListPageState extends State<MainToDoListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainHome(),
    );
  }
}
