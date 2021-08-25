import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DatePickTodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SfDateRangePicker(
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
          todayHighlightColor: Colors.black,
          selectionMode: DateRangePickerSelectionMode.single,
          onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
            // setState(() {
            //   date = DateFormat('MM월 dd일').format(args.value);
            // });
          },
        ),
      ],
    );
  }
}
