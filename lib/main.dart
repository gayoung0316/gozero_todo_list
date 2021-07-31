import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/main_home.dart';
import 'package:todo_list/provider/todo_list_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ToDoListProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
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
