import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:masjed/MoshrefUi/examDataShow/examDataShow.dart';
import 'package:masjed/appBar.dart';
import 'package:masjed/certification.dart';
import 'package:masjed/generalBottomBar.dart';
import 'package:masjed/model/ExamModel.dart';
import 'package:masjed/nameData.dart';
import 'package:provider/provider.dart';
import '../../../../bottomBar.dart';
import '../../provider.dart';
import '../drawer/drawer.dart';
import '../myData/dataPlace.dart';
import '../../main.dart';

class ExamSuccessAdding extends StatefulWidget {
  Widget widget;
  Widget drawer;
  ExamSuccessAdding(this.widget,this.drawer);

  @override
  _ExamSuccessAddingState createState() => _ExamSuccessAddingState();
}

class _ExamSuccessAddingState extends State<ExamSuccessAdding> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool enable=false;

  bool read=true;
  TextEditingController con1=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProviderMasjed>(context,listen: false).conExamName1.text=Provider.of<ProviderMasjed>(context,listen: false).pressedExam.examName;
    Provider.of<ProviderMasjed>(context,listen: false).conExamStudent11.text=Provider.of<ProviderMasjed>(context,listen: false).pressedExam.studentName;
    Provider.of<ProviderMasjed>(context,listen: false).conExamDate1.text=Provider.of<ProviderMasjed>(context,listen: false).pressedExam.examDate;
    Provider.of<ProviderMasjed>(context,listen: false).conExamMark1.text=Provider.of<ProviderMasjed>(context,listen: false).pressedExam.grade;
    Provider.of<ProviderMasjed>(context,listen: false).conExamEstimation1.text=Provider.of<ProviderMasjed>(context,listen: false).pressedExam.estimation;
    Provider.of<ProviderMasjed>(context,listen: false).conExamChain11.text=Provider.of<ProviderMasjed>(context,listen: false).pressedExam.chainName;
    Provider.of<ProviderMasjed>(context,listen: false).conExamPerson1.text=Provider.of<ProviderMasjed>(context,listen: false).pressedExam.examPerson;
  }
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
                  chainName:ProviderMasjed.conExamChain11.text,
                  estimation: ProviderMasjed.conExamEstimation1.text,
                  examDate: ProviderMasjed.conExamDate1.text,
                  examName: ProviderMasjed.conExamName1.text,
                  examPerson: ProviderMasjed.conExamPerson1.text,
                  grade: ProviderMasjed.conExamMark1.text,
                  studentName:ProviderMasjed.conExamStudent11.text,
                );
                print(ProviderMasjed.conExamChain11.text);
                FirebaseFirestore.instance
                    .collection("exams")
                    .where("studentName", isEqualTo : ProviderMasjed.pressedExam.studentName)
                    .where("examName", isEqualTo : ProviderMasjed.pressedExam.examName)
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
              NameInAddingData(Icon(Icons.account_circle_outlined,size: 100,color: Colors.black,), read, enable, "اسم الطالب", '',ProviderMasjed.conExamStudent11,(v){}),
              SizedBox(height: 20,),
              DataPlace("اسم الجزء", ProviderMasjed.conExamName1, '', read, enable),
              DataPlace("تاريخ الاختبار", ProviderMasjed.conExamDate1, '', read, enable),
              DataPlace("العلامة بالدرجات", ProviderMasjed.conExamMark1,'', read, enable),
              DataPlace("التقدير", ProviderMasjed.conExamEstimation1, '', read, enable),
              DataPlace("اسم الحلقة", ProviderMasjed.conExamChain11, '', read, enable),
              DataPlace("الشيخ المختبر", ProviderMasjed.conExamPerson1, '', read, enable),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: ElevatedButton(
                  onPressed: (){

                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (con)=>PngHome(ExamSuccessAdding(ExamDataShow(),DrawerApp()),DrawerApp())));
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
