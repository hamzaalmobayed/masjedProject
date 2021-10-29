import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:masjed/MoshrefUi/drawer/drawer.dart';
import 'package:masjed/MoshrefUi/examAdding/examAdding.dart';
import 'package:masjed/MoshrefUi/examSuccessAdding/examSuccessAdding.dart';
import 'package:masjed/MoshrefUi/myData/dataPlace.dart';
import 'package:masjed/appBar.dart';
import 'package:masjed/certification.dart';
import 'package:masjed/generalBottomBar.dart';
import 'package:masjed/model/ExamModel.dart';
import 'package:masjed/nameData.dart';
import 'package:provider/provider.dart';
import '../../../../bottomBar.dart';
import '../../provider.dart';

import '../../main.dart';

class ExamResult extends StatefulWidget {
  Widget widget;
  Widget drawer;
  ExamResult(this.widget,this.drawer);

  @override
  _ExamResultState createState() => _ExamResultState();
}

class _ExamResultState extends State<ExamResult> {
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
      endDrawer: widget.drawer,
      endDrawerEnableOpenDragGesture: false,
      bottomNavigationBar: GeneralBottomBar(widget.widget),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: floatingButton(),

    );
  }

  /*************appBar**********/
  Widget appBar() {
    return AppBarCustom(
      "ارشيف الاختبارات",
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
  Widget floatingButton(){
    return Consumer<ProviderMasjed>(
      builder:(context,ProviderMasjed,x)=> Padding(
        padding: const EdgeInsets.only(top: 80.0),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 35,
          child: FloatingActionButton(
            backgroundColor: mainColor,
            onPressed: (){
              setState(() {
                enable=!enable;
                read=!read;
              });
              if(enable==false){
                Exam_model exam=Exam_model(
                  chainName:ProviderMasjed.conExamChain1.text==null? ProviderMasjed.selectedChain.chainName:ProviderMasjed.conExamChain1.text,
                  estimation: ProviderMasjed.conExamEstimation.text,
                  examDate: ProviderMasjed.conExamDate.text,
                  examName: ProviderMasjed.conExamName.text,
                  examPerson: ProviderMasjed.conExamPerson.text,
                  grade: ProviderMasjed.conExamMark.text,
                  studentName:ProviderMasjed.conExamStudent1.text==null? ProviderMasjed.selectedChainStudent.studentName:ProviderMasjed.conExamStudent1.text,
                );
                FirebaseFirestore.instance
                    .collection("exams")
                    .where("studentName", isEqualTo : ProviderMasjed.selectedChainStudent.studentName)
                    .where("examName", isEqualTo : ProviderMasjed.conExamName.text)
                    .get().then((value){
                  value.docs.forEach((element) {
                    FirebaseFirestore.instance.collection("exams").doc(element.id).update(exam.toMap()).then((value){
                      print("Success!");
                    });
                  });
                });
              }
            },
            child: Icon(Icons.edit,color: Colors.white,size: 30,),
          ),
        ),
      ),
    );
  }
  /*************body**********/
  Widget body(){
    return Consumer<ProviderMasjed>(
      builder: (con,ProviderMasjed,x)=> SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:20.0,left: 10,right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              NameInAddingData(Icon(Icons.account_circle_outlined,size: 100,color: Colors.black,), read, enable, "اسم الطالب", ProviderMasjed.selectedChainStudent.studentName,ProviderMasjed.conExamStudent1,(v){}),
              SizedBox(height: 20,),
              DataPlace("اسم الجزء", ProviderMasjed.conExamName, ProviderMasjed.conExamName.text, read, enable),
              DataPlace("اسم الحلقة", ProviderMasjed.conExamChain1,ProviderMasjed.selectedChain.chainName , read, enable),
              DataPlace("العلامة بالدرجات", ProviderMasjed.conExamMark, ProviderMasjed.conExamMark.text, read, enable),
              DataPlace("التقدير", ProviderMasjed.conExamEstimation, ProviderMasjed.conExamEstimation.text, read, enable),
              DataPlace("تاريخ الاختبار", ProviderMasjed.conExamDate, ProviderMasjed.conExamDate.text, read, enable),
              DataPlace("الشيخ المختبر", ProviderMasjed.conExamPerson, ProviderMasjed.conExamPerson.text, read, enable),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: ElevatedButton(
                  onPressed: (){
                    Exam_model exam=Exam_model(
                      chainName:ProviderMasjed.conExamChain1.text==null? ProviderMasjed.selectedChain.chainName:ProviderMasjed.conExamChain1.text,
                      estimation: ProviderMasjed.conExamEstimation.text,
                      examDate: ProviderMasjed.conExamDate.text,
                      examName: ProviderMasjed.conExamName.text,
                      examPerson: ProviderMasjed.conExamPerson.text,
                      grade: ProviderMasjed.conExamMark.text,
                      studentName:ProviderMasjed.conExamStudent1.text==null? ProviderMasjed.selectedChainStudent.studentName:ProviderMasjed.conExamStudent1.text,
                    );
                    ProviderMasjed.getPressedExam(exam);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (con)=>PngHome(ExamResult(ExamAdding(),DrawerApp()),DrawerApp())));
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(mainColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          )
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text("اصدار شهادة",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold,),),
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
