import 'package:flutter/material.dart';
import 'package:masjed/MoshrefUi/dataProcessScreen/screen.dart';
import 'package:masjed/appBar.dart';
import 'package:masjed/MoshrefUi/drawer/drawer.dart';
import 'package:masjed/generalBottomBar.dart';
import 'package:masjed/main.dart';
import 'package:masjed/MoshrefUi/mohafethAdding/textFieldAdding.dart';
import 'package:masjed/MoshrefUi/moshref/Moshref.dart';
import 'package:masjed/model/ExamModel.dart';
import 'package:masjed/provider.dart';
import 'package:masjed/searchingResult/examResult.dart';
import 'package:provider/provider.dart';
import '../../bottomBar.dart';
import '../../lists.dart';
import '../examSuccessAdding/examSuccessAdding.dart';
import 'beginOfPage.dart';
class ExamAdding extends StatefulWidget {
  @override
  _ExamAddingState createState() => _ExamAddingState();
}

class _ExamAddingState extends State<ExamAdding> {
  TextEditingController con=TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool enable=true;

  bool read=false;
  TextEditingController con1=TextEditingController();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 0),(){
      Provider.of<ProviderMasjed>(context,listen: false).getChainFromFirestore();

    });
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
      endDrawer: DrawerApp(),
      endDrawerEnableOpenDragGesture: false,
      bottomNavigationBar: GeneralBottomBar(Screen(exams, "اختبار الاجزاء")),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: floatingButton(),
    );
  }

  /*************appBar**********/
  Widget appBar() {
    return AppBarCustom(
      "اضافة اختبار",
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
              Exam_model exam=Exam_model(
                chainName: ProviderMasjed.selectedChain.chainName,
                estimation: ProviderMasjed.conExamEstimation.text,
                examDate: ProviderMasjed.conExamDate.text,
                examName: ProviderMasjed.conExamName.text,
                examPerson: ProviderMasjed.conExamPerson.text,
                grade: ProviderMasjed.conExamMark.text,
                studentName: ProviderMasjed.selectedChainStudent.studentName,
              );
              ProviderMasjed.add("exams", exam.toMap());
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (con) => ExamResult(ExamAdding(),DrawerApp())));
            },
            child: Icon(Icons.add,color: Colors.white,size: 30,),
          ),
        ),
      ),
    );
  }
  /*************body**********/
  Widget body(){
    return Consumer<ProviderMasjed>(
      builder:(context,ProviderMasjed,x)=> SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:20.0,left: 20,right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    BeginOfPage(Icon(Icons.post_add,color: Colors.black, size: 70)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          TextFieldAdding("الجزء المختبر", ProviderMasjed.conExamName),
                          TextFieldAdding("العلامة بالدرجات", ProviderMasjed.conExamMark),
                          TextFieldAdding("التقدير", ProviderMasjed.conExamEstimation),
                          TextFieldAdding("تاريخ الاختبار", ProviderMasjed.conExamDate),
                          TextFieldAdding("الشيخ المختبر", ProviderMasjed.conExamPerson),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
