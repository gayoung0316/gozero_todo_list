import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_list/provider/todo_list_provider.dart';

import 'complete_todo.dart';

class DatePickTodoList extends StatefulWidget {
  @override
  _DatePickTodoListState createState() => _DatePickTodoListState();
}

class _DatePickTodoListState extends State<DatePickTodoList> {
  ToDoListProvider? toDoListProvider;
  String month = '';
  DateRangePickerController _controller = DateRangePickerController();

  @override
  void initState() {
    _controller.selectedDate = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    toDoListProvider = Provider.of<ToDoListProvider>(context);

    return ListView(
      children: [
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
          padding: EdgeInsets.only(bottom: 32.w, left: 16.w, top: 19.w),
          child: Text(
            month,
            textScaleFactor: 1,
            style: TextStyle(
              color: Color(0xff22232B),
              fontSize: 30.sp,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
              fontFamily: 'SeoulNamsan',
            ),
          ),
        ),
        SfDateRangePicker(
          view: DateRangePickerView.month,
          controller: _controller,
          viewSpacing: 10.w,
          monthViewSettings: DateRangePickerMonthViewSettings(
            firstDayOfWeek: 7,
            viewHeaderHeight: 35.w,
            viewHeaderStyle: DateRangePickerViewHeaderStyle(
              textStyle: TextStyle(
                color: Color(0xff535359),
                fontSize: 12.sp,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
                fontFamily: 'SeoulNamsan',
              ),
            ),
          ),
          onViewChanged: (DateRangePickerViewChangedArgs args) {
            final PickerDateRange _visibleDateRange = args.visibleDateRange;
            month = DateFormat('M월').format(_visibleDateRange.startDate!);
          },
          headerHeight: 0.w,
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
        ),
        Divider(
          color: Color(0xffE0DEDB),
          thickness: 2.w,
          height: 0,
        ),
        Padding(
          padding: EdgeInsets.only(top: 24.w, left: 19.w),
          child: Text(
            '${DateFormat('MM월 dd일').format(_controller.selectedDate!)}의 체크리스트',
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
            visible: DateFormat('MM월 dd일').format(_controller.selectedDate!) ==
                todo.date,
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
