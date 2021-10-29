import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:masjed/MoshrefUi/drawer/drawer.dart';
import 'package:masjed/MoshrefUi/drawer/studentDrawer.dart';
import 'package:masjed/MoshrefUi/examSearchData/examResult.dart';
import 'package:masjed/MoshrefUi/examSearching/examSearching.dart';
import 'package:masjed/MoshrefUi/examSuccessAdding/examSuccessAdding.dart';
import 'package:masjed/StudentUi/student/student.dart';
import 'package:masjed/StudentUi/studentExamShowData/studentExamShowData.dart';
import 'package:masjed/model/ExamModel.dart';
import 'package:masjed/model/StudentModel.dart';
import 'package:masjed/provider.dart';
import 'package:provider/provider.dart';
import '../../appBar.dart';
import '../../bottomBar.dart';
import '../../generalBottomBar.dart';
import '../../main.dart';
import '../../nameData.dart';

class StudentExamData extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  BuildContext cont;
  @override
  Widget build(BuildContext context) {
    cont = context;
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: appBar(),
      ),
      body: body(),
      endDrawer: StudentDrawer(),
      endDrawerEnableOpenDragGesture: false,
      bottomNavigationBar: GeneralBottomBar(Student()),
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
  Widget body() {
    final Stream<QuerySnapshot> _usersStream =
        FirebaseFirestore.instance.collection('exams').snapshots();
    return Consumer<ProviderMasjed>(
      builder: (context, ProviderMasjed, x) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              ExamResult("م.", "تاريخ الاختبار", "الجزء المختبر", "العلامة",
                  Colors.white, mainColor, () {}, () {}),
              StreamBuilder<QuerySnapshot>(
                stream: _usersStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  int count = 0;
                  int num;
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return num == 0
                      ? Center(
                          child: Text(
                            "لا يوجد اختبارات",
                            style: TextStyle(color: mainColor, fontSize: 20),
                          ),
                        )
                      : Column(
                          children: snapshot.data.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;
                            if((ProviderMasjed.loginUser as Student_model).studentName==data['studentName']){
                              num = ++count;
                              return ExamResult(
                                  num.toString(),
                                  data['examDate'],
                                  data['examName'],
                                  data['grade'],
                                  mainColor,
                                  Colors.white, () {
                                Navigator.of(cont).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (con) => StudentExamShowData(
                                            StudentExamData(),
                                            Exam_model.fromMap(data))));
                              }, () {});
                            }else{
                              return SizedBox.shrink();
                            }
                          }).toList(),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
