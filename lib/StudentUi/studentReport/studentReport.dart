import 'package:flutter/material.dart';
import 'package:masjed/appBar.dart';
import 'package:masjed/MoshrefUi/drawer/drawer.dart';
import 'package:masjed/generalBottomBar.dart';
import 'package:masjed/main.dart';
import 'package:masjed/MoshrefUi/myData/dataPlace.dart';
import 'package:masjed/model/StudentModel.dart';
import 'package:masjed/nameData.dart';
import 'package:masjed/MoshrefUi/reportAdding/beginEngHefth.dart';
import 'package:masjed/provider.dart';
import 'package:provider/provider.dart';

import '../../bottomBar.dart';
class StudentReport extends StatefulWidget {
  Widget widget;
  Widget drawer;
  StudentReport(this.widget,this.drawer);

  @override
  _StudentReportState createState() => _StudentReportState();
}

class _StudentReportState extends State<StudentReport> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController con=TextEditingController();
  bool enable=true;

  bool read=false;
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
      endDrawer: widget.drawer,
      endDrawerEnableOpenDragGesture: false,
      bottomNavigationBar: GeneralBottomBar(widget.widget),

    );
  }

  /*************appBar**********/
  Widget appBar() {
    return AppBarCustom(
      "تقرير حفظ الطالب",
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
    return Consumer<ProviderMasjed>(
      builder:(context,ProviderMasjed,x)=> SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:20.0,left: 10,right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              NameInAddingData(Icon(Icons.account_circle_outlined,size: 100,color: Colors.black,), true, false, "اسم الطالب", ((ProviderMasjed.loginUser as Student_model).studentName),ProviderMasjed.conStudentReport,(v){
              }),
              SizedBox(height: 20,),
              DataPlace("تاريخ بداية التقرير", con1, ProviderMasjed.selectedStudentReportBegin.date,true, false),
              DataPlace("تاريخ نهاية التقرير", con1, ProviderMasjed.selectedStudentReportEnd.date, true, false),
              BeginEngHefth("بداية الحفظ", "اية", "سورة", con, con,ProviderMasjed.studentReports==null?"":ProviderMasjed.studentReports.first.beginAya, ProviderMasjed.studentReports==null?"":ProviderMasjed.studentReports.first.beginSora, true, false),
              BeginEngHefth("بداية الحفظ", "اية", "سورة", con,con, ProviderMasjed.studentReports==null?"":ProviderMasjed.studentReports.last.endAya, ProviderMasjed.studentReports==null?"":ProviderMasjed.studentReports.last.endSora, true, false),
              DataPlace(" عدد صفحات الحفظ", con1, ProviderMasjed.pageNumber==null?"":ProviderMasjed.pageNumber.toString(),true, false),
              DataPlace("عدد صفحات المراجعة", con1, ProviderMasjed.revisionPage==null?"":ProviderMasjed.revisionPage.toString(), true, false),
              DataPlace("عدد ايام الحضور", con1,ProviderMasjed.coming==null?"": ProviderMasjed.coming.toString(), true, false),
              DataPlace("التقييم العام", con1, ProviderMasjed.assessment==null?"":ProviderMasjed.assessment.toString(), true, false),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: ElevatedButton(
                  onPressed: (){},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(mainColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          )
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10),
                    child: Text("تصدير",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold,),),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
