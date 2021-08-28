import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:todo_list/provider/todo_list_provider.dart';

import '../database/complete_db.dart';
import '../database/db.dart';
import '../model/todo.dart';

// ignore: must_be_immutable
class FunkyOverlay extends StatefulWidget {
  final String? title, description, cancelButtonText, confirmButtonText;
  final Function? onSubmit;
  final int? toDoListIdx;
  final bool? isDeleteItem;
  final bool? isCompleteToDoTitle;
  final PanelController? panelController;

  FunkyOverlay({
    required this.title,
    required this.description,
    required this.cancelButtonText,
    this.confirmButtonText,
    this.onSubmit,
    this.toDoListIdx,
    this.isDeleteItem,
    this.isCompleteToDoTitle,
    this.panelController,
  });

  @override
  State<StatefulWidget> createState() => FunkyOverlayState();
}

class FunkyOverlayState extends State<FunkyOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? scaleAnimation;
  ToDoListProvider? toDoListProvider;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller!, curve: Curves.elasticInOut);
    controller!.addListener(() => setState(() {}));
    controller!.forward();
  }

  Future<void> _deleteDB({
    String? idx,
    String? title,
    int? priority,
    int? color,
    String? date,
  }) async {
    DBHelper db = DBHelper();
    CompleteDBHelper completeDB = CompleteDBHelper();

    await db.deleteMemo(idx!);
    print(await db.memos());

    var completeToDo = ToDo(
      id: idx,
      title: title,
      priority: priority,
      success: 1,
      color: color,
      date: date,
    );

    await completeDB.insertMemo(completeToDo);
    print(await completeDB.memos());
  }

  @override
  Widget build(BuildContext context) {
    toDoListProvider = Provider.of<ToDoListProvider>(context);

    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            color: Color.fromRGBO(16, 13, 13, 0.7),
          ),
        ),
        Container(
          child: ScaleTransition(
            scale: scaleAnimation!,
            child: widget.isDeleteItem! ? deleteItem() : checkItem(),
          ),
        ),
      ],
    );
  }

  Widget checkItem() {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 350.w,
        height: 168.w,
        decoration: BoxDecoration(
          color: Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Column(
          children: <Widget>[
            Column(
              children: [
                SizedBox(height: 32.w),
                Text(
                  widget.title!,
                  textScaleFactor: 1.0,
                  style: TextStyle(
                    color: Color(0xff22232B),
                    fontWeight: FontWeight.w700,
                    fontSize: 18.w,
                  ),
                ),
                SizedBox(height: 24.w),
                Text(
                  widget.description!,
                  textScaleFactor: 1.0,
                  style: TextStyle(
                    color: Color(0xff22232B).withOpacity(0.5),
                    fontWeight: FontWeight.w500,
                    fontSize: 14.w,
                  ),
                ),
                SizedBox(height: 32.w),
              ],
            ),
            Container(
              width: 350.w,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color(0xffFBF9F8),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        widget.panelController!.close();
                      },
                      child: Text(
                        widget.cancelButtonText!,
                        textScaleFactor: 1.0,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff22232B),
                          fontSize: 16.w,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 46.w,
                    child: VerticalDivider(
                      color: Color(0xffFBF9F8),
                      thickness: 1,
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        widget.confirmButtonText!,
                        textScaleFactor: 1.0,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xffFF5A5A),
                          fontSize: 16.w,
                          fontWeight: FontWeight.w700,
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

  Widget deleteItem() {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 350.w,
        height: 187.w,
        decoration: BoxDecoration(
          color: Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: <Widget>[
            Column(
              children: [
                SizedBox(height: 32.w),
                Text(
                  widget.title!,
                  textScaleFactor: 1.0,
                  style: TextStyle(
                    color: Color(0xff22232B),
                    fontWeight: FontWeight.w700,
                    fontSize: 18.w,
                  ),
                ),
                SizedBox(height: 24.w),
                Text(
                  widget.description!,
                  textScaleFactor: 1.0,
                  style: TextStyle(
                    color: Color(0xff22232B).withOpacity(0.5),
                    fontWeight: FontWeight.w500,
                    fontSize: 14.w,
                  ),
                ),
                SizedBox(height: 32.w),
              ],
            ),
            InkWell(
              onTap: () {
                _deleteDB(
                  idx: toDoListProvider!.toDoListIdx,
                  title: toDoListProvider!.completeTitle,
                  priority: toDoListProvider!.completePriority,
                  color: toDoListProvider!.completeColor,
                  date: toDoListProvider!.completeDate,
                );
                Navigator.pop(context);
              },
              child: Container(
                width: 350.w,
                padding: EdgeInsets.only(top: 20.w),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color(0xffFBF9F8),
                      width: 1,
                    ),
                  ),
                ),
                child: Text(
                  widget.confirmButtonText!,
                  textScaleFactor: 1.0,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromRGBO(26, 184, 126, 1),
                    fontSize: 18.w,
                    fontWeight: FontWeight.w700,
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
