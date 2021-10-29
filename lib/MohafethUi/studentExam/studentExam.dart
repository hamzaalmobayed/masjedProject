import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masjed/MohafethUi/Mohafeth/examShowing/examShowing.dart';
import 'package:masjed/MohafethUi/Mohafeth/mohafeth.dart';

import 'package:masjed/MoshrefUi/drawer/mohafethDrawer.dart';
import 'package:masjed/MoshrefUi/report/reportFieldShape.dart';

import 'package:masjed/model/ExamModel.dart';
import 'package:masjed/provider.dart';
import 'package:provider/provider.dart';

import '../../appBar.dart';
import '../../generalBottomBar.dart';
import '../../main.dart';
class StudentExam extends StatefulWidget {
  @override
  _StudentExamState createState() => _StudentExamState();
}

class _StudentExamState extends State<StudentExam> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  BuildContext cont;
  void initState() {
    super.initState();
    Provider.of<ProviderMasjed>(context,listen: false).getAllExamFromFirestore();
  }
  @override
  Widget build(BuildContext context) {
    cont=context;
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: appBar(),
      ),
      endDrawer: MohafethDrawer(),
      endDrawerEnableOpenDragGesture: false,
      body: body(),
      bottomNavigationBar: GeneralBottomBar(Mohafeth()),
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

  Widget body(){
    return Consumer<ProviderMasjed>(
      builder:(context,ProviderMasjed,x)=> Center(
        child: SingleChildScrollView(

          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 314,
                  height: 280,
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
                      ProviderMasjed.allExamChain==null? ReportShape("اسم الطالب","",[]): Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("اسم الطالب",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
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
                              child: DropdownButton<Exam_model>(

                                isExpanded: true,
                                underline: SizedBox(),
                                icon: Icon(Icons.keyboard_arrow_down_sharp,color: Colors.black,),
                                iconSize: 30,
                                items: ProviderMasjed.allExamChain.map((Exam_model value) {
                                  return DropdownMenuItem<Exam_model>(
                                    value: value,
                                    child: Center(child: new Text(value.studentName)),
                                  );
                                }).toList(),
                                onChanged: (v) {
                                  ProviderMasjed.selectExam(v);
                                },
                                value: ProviderMasjed.selectedExam,
                              ),
                            ),
                          )
                        ],
                      ),
                      ProviderMasjed.studentHistory==null? ReportShape("اختر التاريخ","",[]):Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("اختر تاريخ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
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
                              child: DropdownButton<Exam_model>(

                                isExpanded: true,
                                underline: SizedBox(),
                                icon: Icon(Icons.keyboard_arrow_down_sharp,color: Colors.black,),
                                iconSize: 30,
                                items: ProviderMasjed.studentHistory.map((Exam_model value) {
                                  return DropdownMenuItem<Exam_model>(
                                    value: value,
                                    child: Center(child: new Text(value.examDate)),
                                  );
                                }).toList(),
                                onChanged: (v) {
                                  ProviderMasjed.selectHistory(v);
                                },
                                value: ProviderMasjed.selectedHistory,
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
                      ProviderMasjed.getStudentArcheiveFromFirestore();
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(

                              backgroundColor: Colors.white.withOpacity(0),
                              content:Container(alignment: Alignment.center,height: 100,child: CircularProgressIndicator(strokeWidth: 5,color: mainColor,)) ,

                            );
                          });
                      Future.delayed(Duration(seconds: 5)).then((value) => Navigator.of(cont).pushReplacement(
                          MaterialPageRoute(
                              builder: (con) => ExamShowing(StudentExam(),MohafethDrawer()))));
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
