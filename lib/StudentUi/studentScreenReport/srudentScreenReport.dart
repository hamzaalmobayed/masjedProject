import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masjed/MoshrefUi/dailyhefth/hefth.dart';
import 'package:masjed/MoshrefUi/drawer/mohafethDrawer.dart';
import 'package:masjed/MoshrefUi/drawer/studentDrawer.dart';
import 'package:masjed/MoshrefUi/report/reportFieldShape.dart';
import 'package:masjed/MoshrefUi/reportAdding/reportAdding.dart';
import 'package:masjed/StudentUi/student/student.dart';
import 'package:masjed/StudentUi/studentReport/studentReport.dart';
import 'package:masjed/generalBottomBar.dart';
import 'package:masjed/model/HefthModel.dart';
import 'package:masjed/model/StudentModel.dart';
import 'package:masjed/provider.dart';
import 'package:provider/provider.dart';

import '../../appBar.dart';
import '../../bottomBar.dart';
import '../../main.dart';
class StudentScreenReport extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  BuildContext cont;
  Widget back;
  Widget drawer;

  StudentScreenReport(this.back, this.drawer);

  @override
  Widget build(BuildContext context) {
    cont=context;
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: appBar(),
      ),
      endDrawer: drawer,
      endDrawerEnableOpenDragGesture: false,
      body: body(),
      bottomNavigationBar: GeneralBottomBar(back),
    );
  }
  /*************appBar**********/
  Widget appBar() {
    return AppBarCustom(
      "",
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
      builder: (context,ProviderMasjed,x)=>Center(
        child: SingleChildScrollView(

          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 314,
                  height: 350,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 10.0,
                        ),
                      ],
                      color:mainColor,
                      borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      ProviderMasjed.studentReportBegin==null?ReportShape("بداية التقرير","",[]):Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("بداية التقرير",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
                          SizedBox(height: 5,),
                          Container(
                            width: 270,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.fromBorderSide(BorderSide(width: 1,)),
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 10.0,
                                ),
                              ],),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: DropdownButton<Hefth_Model>(

                                isExpanded: true,
                                underline: SizedBox(),
                                icon: Icon(Icons.keyboard_arrow_down_sharp,color: Colors.black,),
                                iconSize: 30,
                                items:  ProviderMasjed.studentReportBegin.map((Hefth_Model value) {
                                  return DropdownMenuItem<Hefth_Model>(
                                    value: value,
                                    child: Center(child: new Text(value.date)),
                                  );
                                }).toList(),
                                onChanged: (v) {
                                  ProviderMasjed.selectStudentReportBegin(v);
                                },
                                value:ProviderMasjed.selectedStudentReportBegin ,
                              ),
                            ),
                          )
                        ],
                      ),
                      ProviderMasjed.studentReportEnd==null?ReportShape("نهاية التقرير","",[]):Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("نهاية التقرير",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
                          SizedBox(height: 5,),
                          Container(
                            width: 270,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.fromBorderSide(BorderSide(width: 1,)),
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 10.0,
                                ),
                              ],),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: DropdownButton<Hefth_Model>(

                                isExpanded: true,
                                underline: SizedBox(),
                                icon: Icon(Icons.keyboard_arrow_down_sharp,color: Colors.black,),
                                iconSize: 30,
                                items:ProviderMasjed.studentReportEnd.map((Hefth_Model value) {
                                  return DropdownMenuItem<Hefth_Model>(
                                    value: value,
                                    child: Center(child: new Text(value.date)),
                                  );
                                }).toList(),
                                onChanged: (v) {
                                  ProviderMasjed.selectStudentReportEnd(v);
                                },
                                value: ProviderMasjed.selectedStudentReportEnd,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ) ,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 80),
                  child: ElevatedButton(
                    onPressed: () {
                      ProviderMasjed.getStudentReportFromFirestore((ProviderMasjed.loginUser as Student_model).studentName,ProviderMasjed.selectedStudentReportBegin.date,ProviderMasjed.selectedStudentReportEnd.date);

                      Navigator.of(cont).pushReplacement(
                          MaterialPageRoute(
                              builder: (con) => StudentReport(StudentScreenReport(back,drawer),drawer)));
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              side: BorderSide(width: 2,color: mainColor),
                              borderRadius: BorderRadius.circular(50.0),
                            )
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("تم",style: TextStyle(fontSize: 20,color: mainColor,fontWeight: FontWeight.bold,),),
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
