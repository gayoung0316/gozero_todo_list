import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_list/provider/todo_list_provider.dart';

class DatePickTodoList extends StatelessWidget {
  late final ToDoListProvider? toDoListProvider;

  @override
  Widget build(BuildContext context) {
    toDoListProvider = Provider.of<ToDoListProvider>(context);

    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 44.w),
          child: SfDateRangePicker(
            view: DateRangePickerView.month,
            monthViewSettings: DateRangePickerMonthViewSettings(
              firstDayOfWeek: 1,
            ),
            headerHeight: 0,
            monthCellStyle: DateRangePickerMonthCellStyle(
              textStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: Color(0xff22232B),
              ),
              todayCellDecoration: BoxDecoration(
                color: Colors.transparent,
              ),
              todayTextStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: Color(0xff22232B),
              ),
            ),
            selectionColor: Color(0xff76706B),
            selectionTextStyle: TextStyle(
              color: Color(0xffF5F4F2),
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
            ),
            todayHighlightColor: Colors.black,
            selectionMode: DateRangePickerSelectionMode.single,
            onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
              toDoListProvider!.todayDate =
                  DateFormat('MM월 dd일').format(args.value);
            },
          ),
        ),
        Divider(
          color: Color(0xffE0DEDB),
          thickness: 2.w,
          height: 0,
        ),
        Padding(
          padding: EdgeInsets.only(top: 24.w, left: 19.w),
          child: Text(
            '${toDoListProvider!.todayDate}의 체크리스트',
            style: TextStyle(
              color: Color(0xff22232B),
              fontWeight: FontWeight.w700,
              letterSpacing: 2.w,
              fontSize: 18.sp,
            ),
          ),
        ),
        SizedBox(height: 24.w),
        ...toDoListProvider!.toDoList.map((todo) {
          return Visibility(
            visible: toDoListProvider!.todayDate == todo.date,
            child: Padding(
              padding: EdgeInsets.only(left: 19.w, bottom: 16.w),
              child: Text(
                '${todo.title}',
                textScaleFactor: 1,
                style: TextStyle(
                  color: Color(0xff22232B),
                  letterSpacing: 2,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
