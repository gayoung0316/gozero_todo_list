import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/database/db.dart';
import 'package:todo_list/database/todo.dart';
import 'package:todo_list/provider/todo_list_provider.dart';
import 'package:crypto/crypto.dart';

import 'widget/dialog_widget.dart';

class ToDoListAdd extends StatefulWidget {
  @override
  _ToDoListAddState createState() => _ToDoListAddState();
}

class _ToDoListAddState extends State<ToDoListAdd> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  ToDoListProvider? toDoListProvider;

  String strSha512(String text) {
    var bytes = utf8.encode(text); // data being hashed
    var digest = sha512.convert(bytes);
    return digest.toString();
  }

  Future<void> _insertDB() async {
    DBHelper db = DBHelper();

    var todo = ToDo(
      id: strSha512(DateTime.now().toString()),
      title: titleController.text,
      priority: toDoListProvider!.priority,
      success: 0,
      color: toDoListProvider!.colorSelect,
      date: DateFormat('MM월 dd일').format(DateTime.now()),
    );

    await db.insertMemo(todo);
    print(await db.memos());
  }

  List<Color> colorList = [
    Color(0xffFF5A5A),
    Color(0xffFFC977),
    Color(0xffA5E98E),
    Color(0xff8EE9D3),
    Color(0xff8ACEFF),
    Color(0xff9A8AFF),
    Color(0xffE7FE5C),
    Color(0xff5CFEC4),
    Color(0xffF3F1EF),
    Color(0xffF1EBE5),
  ];

  @override
  Widget build(BuildContext context) {
    toDoListProvider = Provider.of<ToDoListProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            showDialog(
                              barrierDismissible: false,
                              useSafeArea: false,
                              barrierColor: Color.fromRGBO(16, 13, 13, 0.7),
                              context: context,
                              builder: (BuildContext context) => FunkyOverlay(
                                title: "아직 할 일을 작성하지 않았어요",
                                description: "오늘 할 일을 내일로 미룰겁니까?",
                                cancelButtonText: "내일 할래",
                                confirmButtonText: '오늘 할래',
                                isDeleteItem: false,
                              ),
                            );
                          },
                          child: Image.asset(
                            'assets/left_arrow.png',
                            width: 8.w,
                            height: 18.w,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffE2DED8),
                              width: 1.w,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(1000.w),
                            child: Image.asset(
                              'assets/profile.JPG',
                              width: 40.w,
                              height: 40.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 16.w, right: 20.w, left: 20.w),
                    child: Text(
                      '오늘 내 할 일은?',
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: Color(0xff22232B),
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16.w, right: 20.w, left: 20.w),
                    height: 84.w,
                    child: TextField(
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.done,
                      controller: titleController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '모두 힘을 내 작성해 보아요.',
                        hintStyle: TextStyle(
                          color: Color(0xff22232B).withOpacity(0.5),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 16.w, right: 20.w, left: 20.w),
                    child: Text(
                      '얼만큼 중요한가요?',
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: Color(0xff22232B),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      toDoListProvider!.priority = 3;
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 24.w,
                        bottom: 8.w,
                        left: 20.w,
                        right: 20.w,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.w),
                        color: toDoListProvider!.priority == 3
                            ? Color(0xffF1EBE5)
                            : Color(0xffFBF9F8),
                      ),
                      height: 48.w,
                      child: Center(
                        child: Text(
                          '그냥 일단 적어두는 거야',
                          style: TextStyle(
                            color: Color(0xff22232B),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      toDoListProvider!.priority = 2;
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: 8.w,
                        left: 20.w,
                        right: 20.w,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.w),
                        color: toDoListProvider!.priority == 2
                            ? Color(0xffF1EBE5)
                            : Color(0xffFBF9F8),
                      ),
                      height: 48.w,
                      child: Center(
                        child: Text(
                          '해야 하지만 오늘 하기엔 어려울 거 같아',
                          style: TextStyle(
                            color: Color(0xff22232B),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      toDoListProvider!.priority = 1;
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: 32.w,
                        left: 20.w,
                        right: 20.w,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.w),
                        color: toDoListProvider!.priority == 1
                            ? Color(0xffF1EBE5)
                            : Color(0xffFBF9F8),
                      ),
                      height: 48.w,
                      child: Center(
                        child: Text(
                          '이거 안 하면 난 바보다',
                          style: TextStyle(
                            color: Color(0xff22232B),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 24.w,
                      left: 20.w,
                      right: 20.w,
                    ),
                    child: Text(
                      '오늘을 다채롭게',
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: Color(0xff22232B),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Wrap(
                    children: [
                      ...colorList.map(
                        (color) {
                          String colorIdx =
                              color.toString().split('(')[1].split(')')[0];
                          return InkWell(
                            onTap: () {
                              toDoListProvider!.colorSelect =
                                  int.parse(colorIdx);
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 20.w, bottom: 16.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: color,
                              ),
                              width: 32.w,
                              height: 32.w,
                              child: Center(
                                child: toDoListProvider!.colorSelect ==
                                        int.parse(colorIdx)
                                    ? Icon(
                                        Icons.check,
                                        size: 15.w,
                                        color: Colors.black38,
                                      )
                                    : Container(),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 70.w),
                ],
              ),
            ),
            Visibility(
              visible: titleController.text.isNotEmpty &&
                  toDoListProvider!.priority != 0 &&
                  toDoListProvider!.colorSelect != 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 34.w),
                    child: InkWell(
                      onTap: () {
                        _insertDB();
                        toDoListProvider!.priority = 0;
                        toDoListProvider!.colorSelect = 0;
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Text(
                          '작성 완료!',
                          textScaleFactor: 1,
                          style: TextStyle(
                            color: Color(0xff22232B),
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
