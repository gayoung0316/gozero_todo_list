import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/provider/todo_list_provider.dart';

// ignore: must_be_immutable
class BackgroundColorChoice extends StatelessWidget {
  ToDoListProvider? toDoListProvider;

  @override
  Widget build(BuildContext context) {
    toDoListProvider = Provider.of<ToDoListProvider>(context);

    return Scaffold(
      backgroundColor: Color(0xff22232B).withOpacity(0.6),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 32.w),
          height: 187.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.w),
          ),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 32.w),
                Text(
                  '배경 색상 선택',
                  textScaleFactor: 1,
                  style: TextStyle(
                    color: Color(0xff22232B),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 24.w),
                Text(
                  '오늘은 무슨 색으로 할까요?',
                  textScaleFactor: 1,
                  style: TextStyle(
                    color: Color(0xff22232B).withOpacity(0.5),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 32.w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        backgroundColor(1);
                      },
                      child: Container(
                        width: 32.w,
                        height: 32.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.w),
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        backgroundColor(2);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 16.w),
                        width: 32.w,
                        height: 32.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.w),
                          color: Colors.black,
                          border: Border.all(
                            color: Color(0xffE2DED9),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        backgroundColor(3);
                      },
                      child: Container(
                        width: 32.w,
                        height: 32.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.w),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xffF7CAC9),
                              Color(0xff92A8D1),
                            ],
                          ),
                          border: Border.all(
                            color: Color(0xffE2DED9),
                            width: 1,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void backgroundColor(int color) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setInt('colorIdx', color);
    toDoListProvider!.backgroundColor = color;
    toDoListProvider!.backgroundColorChoice = false;
  }
}
