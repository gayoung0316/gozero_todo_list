import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:todo_list/database/write_db.dart';
import 'package:todo_list/model/todo.dart';
import 'package:todo_list/provider/todo_list_provider.dart';
import 'package:crypto/crypto.dart';

import 'widget/dialog_widget.dart';

class ToDoListAdd extends StatefulWidget {
  final PanelController panelController;
  ToDoListAdd(this.panelController);

  @override
  _ToDoListAddState createState() => _ToDoListAddState();
}

class _ToDoListAddState extends State<ToDoListAdd> {
  final titleController = TextEditingController();
  ToDoListProvider? toDoListProvider;

  String strSha512(String text) {
    var bytes = utf8.encode(text); // data being hashed
    var digest = sha512.convert(bytes);
    return digest.toString();
  }

  Future<void> _insertDB() async {
    ToDoDBHelper db = ToDoDBHelper();

    var todo = ToDo(
      id: strSha512(DateTime.now().toString()),
      title: toDoListProvider!.textEditingController.text,
      priority: toDoListProvider!.priority,
      success: 0,
      color: toDoListProvider!.colorSelect,
      date: toDoListProvider!.todayDate,
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
      backgroundColor: toDoListProvider!.backgroundColor == 3
          ? Colors.transparent
          : toDoListProvider!.backgroundColor == 2
              ? Colors.black
              : toDoListProvider!.backgroundColor == 4
                  ? Color(0xffE5E5E5)
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
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 50.w, right: 20.w),
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              barrierDismissible: false,
                              useSafeArea: false,
                              barrierColor: Color.fromRGBO(16, 13, 13, 0.7),
                              context: context,
                              builder: (BuildContext context) => FunkyOverlay(
                                title: "?????? ??? ?????? ???????????? ????????????",
                                description: "?????? ??? ?????? ????????? ????????????????",
                                cancelButtonText: "?????? ??????",
                                confirmButtonText: '?????? ??????',
                                isDeleteItem: false,
                                panelController: widget.panelController,
                              ),
                            );
                          },
                          child: Text(
                            '??????',
                            textScaleFactor: 1,
                            style: TextStyle(
                              color: toDoListProvider!.backgroundColor == 2
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
                  Padding(
                    padding:
                        EdgeInsets.only(top: 16.w, right: 20.w, left: 20.w),
                    child: Text(
                      '?????? ??? ??? ???????',
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: toDoListProvider!.backgroundColor == 2
                            ? Colors.white
                            : Color(0xff22232B),
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
                      controller: toDoListProvider!.textEditingController,
                      style: TextStyle(
                        color: toDoListProvider!.backgroundColor == 2
                            ? Colors.white
                            : Color(0xff22232B),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '?????? ?????? ??? ????????? ?????????.',
                        hintStyle: TextStyle(
                          color: toDoListProvider!.backgroundColor == 2
                              ? Colors.white.withOpacity(0.5)
                              : Color(0xff22232B).withOpacity(0.5),
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
                      '????????? ????????????????',
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: toDoListProvider!.backgroundColor == 2
                            ? Colors.white
                            : Color(0xff22232B),
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
                          '?????? ?????? ???????????? ??????',
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
                          '?????? ????????? ?????? ????????? ???????????????',
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
                          '?????? ??? ?????? ??? ?????????',
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
                      '????????? ????????????',
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: toDoListProvider!.backgroundColor == 2
                            ? Colors.white
                            : Color(0xff22232B),
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
              visible:
                  toDoListProvider!.textEditingController.text.isNotEmpty &&
                      toDoListProvider!.priority != 0 &&
                      toDoListProvider!.colorSelect != 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 45.w),
                    child: InkWell(
                      onTap: () {
                        _insertDB();
                        widget.panelController.close();
                      },
                      child: Center(
                        child: Text(
                          '?????? ??????!',
                          textScaleFactor: 1,
                          style: TextStyle(
                            color: toDoListProvider!.backgroundColor == 2
                                ? Colors.white
                                : Color(0xff22232B),
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
