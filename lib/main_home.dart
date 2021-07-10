import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_list/todo_list_add.dart';

class MainHome extends StatelessWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDateMainTitle = DateFormat('MM월 dd일').format(now);
    List<String> memoList = [
      '정국이는 왜 그렇게 이쁠까?',
      '원우랑 토닥토닥 다정하게',
      '석진이랑 호석이랑',
      '윤기의 무심함은 너의 다정함'
    ];

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 20.sp),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.purple,
                  ),
                  width: 44.sp,
                  height: 44.sp,
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.sp, top: 19.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        formattedDateMainTitle,
                        textScaleFactor: 1,
                        style: TextStyle(
                          color: Color(0xff22232B),
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
                          width: 32.sp,
                          height: 32.sp,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '인생은 한 방이다. 너 마음대로 살아라.',
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
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 34.h),
              child: Wrap(
                children: [
                  ...memoList.map(
                    (e) => Container(
                      height: 100.w,
                      width: 100.w,
                      margin: EdgeInsets.only(
                        left: 5.w,
                        right: 5.w,
                        bottom: 5.w,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xff12312),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text(
                            e,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 200.w,
                    width: 200.w,
                    margin: EdgeInsets.only(
                      left: 5.w,
                      right: 5.w,
                      bottom: 5.w,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xff12312),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text(
                          '가영이랑 정국이랑 알콩달콩',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 200.w,
                    width: 200.w,
                    margin: EdgeInsets.only(
                      left: 5.w,
                      right: 5.w,
                      bottom: 5.w,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xff12312),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text(
                          '아련이랑 원우랑 알콩달콩',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 150.w,
                    width: 150.w,
                    margin: EdgeInsets.only(
                      left: 5.w,
                      right: 5.w,
                      bottom: 5.w,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xff12312),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text(
                          '오늘에도 행복만 가득하길 ',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
