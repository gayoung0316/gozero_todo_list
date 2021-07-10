import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ToDoListAdd extends StatefulWidget {
  const ToDoListAdd({Key? key}) : super(key: key);

  @override
  _ToDoListAddState createState() => _ToDoListAddState();
}

class _ToDoListAddState extends State<ToDoListAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.purple,
                      ),
                      width: 44.w,
                      height: 44.w,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16.w, right: 20.w, left: 20.w),
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
                  // textInputAction: TextInputAction.done,
                  // keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '모두 힘을 내 작성해 보아요.',
                    hintStyle: TextStyle(
                      color: Color(0xff22232B),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16.w, right: 20.w, left: 20.w),
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
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.only(
                    top: 24.w,
                    bottom: 8.w,
                    left: 20.w,
                    right: 20.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xffF1EBE5),
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
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: 8.w,
                    left: 20.w,
                    right: 20.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xffFBF9F8),
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
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: 32.w,
                    left: 20.w,
                    right: 20.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xffFBF9F8),
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
                  Container(
                    margin: EdgeInsets.only(left: 20.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xffFF5A5A),
                    ),
                    width: 32.w,
                    height: 32.w,
                  ),
                  // Container(
                  //   margin: EdgeInsets.symmetric(horizontal: 20.w),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(8),
                  //     color: Color(0xffFFC977),
                  //   ),
                  //   width: 32.w,
                  //   height: 32.w,
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
