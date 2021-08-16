import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/provider/todo_list_provider.dart';

import 'database/complete_db.dart';
import 'database/todo.dart';

// ignore: must_be_immutable
class CompleteToDo extends StatelessWidget {
  ToDoListProvider? toDoListProvider;

  Future<List<ToDo>> loadToDoList() async {
    CompleteDBHelper db = CompleteDBHelper();
    var result = await db.memos();
    toDoListProvider!.completeToDoList = result;
    return result;
  }

  @override
  Widget build(BuildContext context) {
    toDoListProvider = Provider.of<ToDoListProvider>(context);

    Widget toDoListBuilder() {
      return FutureBuilder(
        future: loadToDoList(),
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.none &&
              // ignore: unnecessary_null_comparison
              projectSnap.hasData == null) {
            return Container();
          }
          return SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
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
                  SizedBox(height: 19.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '완료 목록',
                        textScaleFactor: 1,
                        style: TextStyle(
                          color: Color(0xff22232B),
                          fontSize: 30.sp,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.w),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '당신의 하루는 웃음만 가득했으면 좋겠다',
                            textScaleFactor: 1,
                            style: TextStyle(
                              color: Color(0xff22232B),
                              fontSize: 16.sp,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 26.w,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/trophy_cup.png',
                        width: 20.w,
                        height: 40.w,
                      ),
                      SizedBox(width: 16.w),
                      Text(
                        '명예의 전당',
                        textScaleFactor: 1,
                        style: TextStyle(
                          color: Color(0xff22232B),
                          letterSpacing: 2.w,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.w),
                  ...toDoListProvider!.completeToDoList.map((ToDo item) {
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xffF1EBE5),
                            // color: Colors.red,
                            borderRadius: BorderRadius.circular(8.w),
                          ),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 19.w),
                              child: Text(
                                item.title!,
                                textScaleFactor: 1,
                                style: TextStyle(
                                  color: Color(0xff22232B),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.w),
                      ],
                    );
                  }),
                ],
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      body: toDoListBuilder(),
    );
  }
}
