import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_list/provider/todo_list_provider.dart';
import 'package:todo_list/widget/background_color_choice.dart';
import 'package:todo_list/widget/setting_box.dart';

class DatePickTodoList extends StatefulWidget {
  final PageController pageController;
  DatePickTodoList(this.pageController);

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

    return Container(
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
      child: GestureDetector(
        onTap: () => toDoListProvider!.isSetting = false,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          toDoListProvider!.isSetting =
                              !toDoListProvider!.isSetting;
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffE2DED8),
                              width: 1.w,
                            ),
                            shape: BoxShape.circle,
                          ),
                          margin: EdgeInsets.only(right: 20.w, top: 50.w),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(1000),
                            child: Image.asset(
                              'assets/app_main_logo.png',
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
                    padding:
                        EdgeInsets.only(bottom: 32.w, left: 16.w, top: 19.w),
                    child: Text(
                      month,
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: toDoListProvider!.backgroundColor == 2
                            ? Colors.white
                            : Color(0xff22232B),
                        fontSize: 30.sp,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SeoulNamsan',
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SfDateRangePicker(
                        view: DateRangePickerView.month,
                        controller: _controller,
                        viewSpacing: 10.w,
                        monthViewSettings: DateRangePickerMonthViewSettings(
                          firstDayOfWeek: 7,
                          viewHeaderHeight: 35.w,
                          viewHeaderStyle: DateRangePickerViewHeaderStyle(
                            textStyle: TextStyle(
                              color: toDoListProvider!.backgroundColor == 2
                                  ? Colors.white
                                  : Color(0xff535359),
                              // color: Color(0xff535359),
                              fontSize: 12.sp,
                              letterSpacing: 2,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'SeoulNamsan',
                            ),
                          ),
                        ),
                        onViewChanged: (DateRangePickerViewChangedArgs args) {
                          final PickerDateRange _visibleDateRange =
                              args.visibleDateRange;
                          month = DateFormat('M???')
                              .format(_visibleDateRange.startDate!);
                        },
                        headerHeight: 0.w,
                        monthCellStyle: DateRangePickerMonthCellStyle(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: toDoListProvider!.backgroundColor == 2
                                ? Colors.white
                                : Color(0xff22232B),
                          ),
                          todayCellDecoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          todayTextStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: toDoListProvider!.backgroundColor == 2
                                ? Colors.white
                                : Color(0xff22232B),
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
                      SizedBox(height: 20.w),
                      Divider(
                        color: Color(0xffE0DEDB),
                        thickness: 2.w,
                        height: 0,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 24.w, left: 19.w),
                    child: Text(
                      '${DateFormat('MM??? dd???').format(_controller.selectedDate!)}??? ???????????????',
                      style: TextStyle(
                        color: toDoListProvider!.backgroundColor == 2
                            ? Colors.white
                            : Color(0xff22232B),
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2.w,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.w),
                  ...toDoListProvider!.toDoList.map((todo) {
                    int index = toDoListProvider!.toDoList.indexOf(todo);
                    return Visibility(
                      visible: DateFormat('MM??? dd???')
                                  .format(_controller.selectedDate!) ==
                              todo.date &&
                          index <= 4,
                      child: Padding(
                        padding: EdgeInsets.only(left: 19.w, bottom: 16.w),
                        child: Text(
                          todo.title!,
                          textScaleFactor: 1,
                          style: TextStyle(
                            color: toDoListProvider!.backgroundColor == 2
                                ? Colors.white
                                : Color(0xff22232B),
                            letterSpacing: 2,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    );
                  }),
                  Visibility(
                    visible: toDoListProvider!.toDoList.length > 5,
                    child: Padding(
                      padding: EdgeInsets.only(left: 19.w),
                      child: Text(
                        '+ ${toDoListProvider!.toDoList.length - 5}?????? ???????????????',
                        textScaleFactor: 1,
                        style: TextStyle(
                          color: toDoListProvider!.backgroundColor == 2
                              ? Colors.white.withOpacity(0.5)
                              : Color(0xff22232B).withOpacity(0.5),
                          letterSpacing: 2,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 80.w),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 80.w,
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      toDoListProvider!.todayDate = DateFormat('MM??? dd???')
                          .format(_controller.selectedDate!);
                      widget.pageController.animateToPage(
                        1,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.linear,
                      );
                    },
                    child: Text(
                      toDoListProvider!.toDoList
                              .where((todo) =>
                                  DateFormat('MM??? dd???')
                                      .format(_controller.selectedDate!) ==
                                  todo.date)
                              .isNotEmpty
                          ? '????????? ??????'
                          : '???????????? ??????',
                      textScaleFactor: 1,
                      style: TextStyle(
                        fontSize: 22.sp,
                        color: toDoListProvider!.backgroundColor == 2
                            ? Colors.white
                            : Color(0xff22232B),
                        letterSpacing: 2,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: toDoListProvider!.backgroundColorChoice,
              child: BackgroundColorChoice(),
            ),
            Visibility(
              visible: toDoListProvider!.isSetting,
              child: SettingBox(),
            ),
          ],
        ),
      ),
    );
  }
}
