import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/provider/todo_list_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../complete_todo_list.dart';

class SettingBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ToDoListProvider? toDoListProvider = Provider.of<ToDoListProvider>(context);
    return Positioned(
      top: 108.w,
      right: 20.w,
      child: Container(
        width: 156.w,
        height: 104.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.w),
          border: Border.all(
            width: 1,
            color: Color(0xffE2DED9),
          ),
          color: Colors.white,
        ),
        padding: EdgeInsets.only(
          top: 23.w,
          left: 16.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                toDoListProvider.isSetting = false;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CompleteToDo(),
                  ),
                );
              },
              child: Container(
                width: 156.w,
                child: Text(
                  '완료 목록',
                  textScaleFactor: 1,
                  style: TextStyle(
                    color: Color(0xff22232B),
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 33.w),
            InkWell(
              onTap: () {
                toDoListProvider.isSetting = false;
                toDoListProvider.backgroundColorChoice = true;
              },
              child: Container(
                width: 156.w,
                child: Text(
                  '배경 색상 설정',
                  textScaleFactor: 1,
                  style: TextStyle(
                    color: Color(0xff22232B),
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
