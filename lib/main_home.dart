import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/background_color_choice.dart';
import 'package:todo_list/database/db.dart';
import 'package:todo_list/todo_list_add.dart';

import 'complete_todo.dart';
import 'database/todo.dart';
import 'dialog_widget.dart';
import 'provider/todo_list_provider.dart';

// ignore: must_be_immutable
class MainHome extends StatelessWidget {
  DBHelper dbHelper = DBHelper();
  ToDoListProvider? toDoListProvider;

  Future<List<ToDo>> loadToDoList() async {
    DBHelper db = DBHelper();
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    int colorIdx = (_prefs.getInt('colorIdx') ?? 0);
    toDoListProvider!.backgroundColor = colorIdx;

    var result = await db.memos();
    toDoListProvider!.toDoList = result;
    return result;
  }

  @override
  Widget build(BuildContext context) {
    toDoListProvider = Provider.of<ToDoListProvider>(context);
    DateTime now = DateTime.now();
    String formattedDateMainTitle = DateFormat('MM월 dd일').format(now);

    Widget toDoListBuilder() {
      return FutureBuilder(
        future: loadToDoList(),
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.none &&
              // ignore: unnecessary_null_comparison
              projectSnap.hasData == null) {
            return Container();
          }
          return Stack(
            children: [
              SafeArea(
                bottom: false,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CompleteToDo(),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xffE2DED8),
                                  width: 1.w,
                                ),
                                shape: BoxShape.circle,
                              ),
                              margin: EdgeInsets.only(right: 20.w),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(1000),
                                child: Image.asset(
                                  'assets/profile.JPG',
                                  width: 40.w,
                                  height: 40.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.w, top: 19.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  formattedDateMainTitle,
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                    color:
                                        toDoListProvider!.backgroundColor == 2
                                            ? Colors.white
                                            : Color(0xff22232B),
                                    fontSize: 30.sp,
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ToDoListAdd(),
                                      ),
                                    );
                                  },
                                  icon: Image.asset(
                                    'assets/todo_plus.png',
                                    width: 32.w,
                                    height: 32.w,
                                    color:
                                        toDoListProvider!.backgroundColor == 2
                                            ? Colors.white
                                            : null,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 16.w),
                              child: InkWell(
                                onTap: () {
                                  toDoListProvider!.backgroundColorChoice =
                                      true;
                                },
                                child: Text(
                                  '인생은 한 방이다. 너 마음대로 살아라.',
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                    color:
                                        toDoListProvider!.backgroundColor == 2
                                            ? Colors.white
                                            : Color(0xff22232B),
                                    fontSize: 16.sp,
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 34.w),
                        child: Wrap(
                          children: [
                            ...toDoListProvider!.toDoList.map(
                              (todo) {
                                return InkWell(
                                  onTap: () {
                                    toDoListProvider!.toDoListIdx = todo.id!;
                                    toDoListProvider!.completeTitle =
                                        todo.title!;
                                    toDoListProvider!.completePriority =
                                        todo.priority!;
                                    toDoListProvider!.completeColor =
                                        todo.color!;

                                    showDialog(
                                      barrierDismissible: false,
                                      useSafeArea: false,
                                      barrierColor:
                                          Color.fromRGBO(16, 13, 13, 0.7),
                                      context: context,
                                      builder: (BuildContext context) =>
                                          FunkyOverlay(
                                        title: "일은 잘 마무리 하였나요?",
                                        description: "오늘 하루도 고생 많았어요",
                                        confirmButtonText: "터뜨리기",
                                        cancelButtonText: '',
                                        isDeleteItem: true,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: todo.priority == 1
                                        ? 200.w
                                        : todo.priority == 2
                                            ? 150.w
                                            : 100.w,
                                    width: todo.priority == 1
                                        ? 200.w
                                        : todo.priority == 2
                                            ? 150.w
                                            : 100.w,
                                    margin: EdgeInsets.only(
                                      left: 5.w,
                                      right: 5.w,
                                      bottom: 5.w,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(
                                          int.parse(todo.color.toString())),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w),
                                        child: Text(
                                          '${todo.title}',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 60.w),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: toDoListProvider!.backgroundColorChoice,
                child: BackgroundColorChoice(),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: toDoListProvider!.backgroundColor == 3
          ? Colors.transparent
          : toDoListProvider!.backgroundColor == 2
              ? Colors.black
              : Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: toDoListProvider!.backgroundColor == 3
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xffF7CAC9),
                    Color(0xff92A8D1),
                  ],
                )
              : null,
        ),
        child: toDoListBuilder(),
      ),
    );
  }
}
