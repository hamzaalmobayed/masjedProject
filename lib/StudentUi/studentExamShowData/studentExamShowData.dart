import 'package:flutter/material.dart';
import 'package:masjed/MoshrefUi/drawer/studentDrawer.dart';
import 'package:masjed/MoshrefUi/myData/dataPlace.dart';
import 'package:masjed/appBar.dart';
import 'package:masjed/model/ExamModel.dart';
import 'package:masjed/nameData.dart';
import '../../../../bottomBar.dart';

import '../../generalBottomBar.dart';
import '../../main.dart';

class StudentExamShowData extends StatefulWidget {
  Widget widget;
  Exam_model e;
  StudentExamShowData(this.widget,this.e);

  @override
  _StudentExamShowDataState createState() => _StudentExamShowDataState();
}

class _StudentExamShowDataState extends State<StudentExamShowData> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool enable=false;

  bool read=true;
  TextEditingController con1=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: appBar(),
      ),
      body: body(),
      endDrawer: StudentDrawer(),
      endDrawerEnableOpenDragGesture: false,
      bottomNavigationBar: GeneralBottomBar(widget.widget),
    );
  }

  /*************appBar**********/
  Widget appBar() {
    return AppBarCustom(
      "ارشيف اختباراتي",
      ImageIcon(
        AssetImage("images/list.jpg"),
        color: Colors.white,
        size: 30,
      ),
          () {
        _scaffoldKey.currentState.openEndDrawer();
      },
    );
  }

  /*************body**********/
  Widget body(){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top:20.0,left: 10,right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            NameInAddingData(Icon(Icons.account_circle_outlined,size: 100,color: Colors.black,), read, enable, "اسم الطالب",  widget.e.studentName,con1 ,(v){}),
            SizedBox(height: 20,),
            DataPlace("اسم الجزء", con1, widget.e.examName, read, enable),
            DataPlace("تاريخ الاختبار", con1,  widget.e.examDate, read, enable),
            DataPlace("العلامة بالدرجات", con1,  widget.e.grade, read, enable),
            DataPlace("التقدير", con1,  widget.e.estimation, read, enable),
            DataPlace("اسم الحلقة", con1,  widget.e.chainName, read, enable),
            DataPlace("الشيخ المختبر", con1,  widget.e.examPerson, read, enable),

          ],
        ),
      ),
    );
  }


}
