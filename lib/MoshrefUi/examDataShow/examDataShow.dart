import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:masjed/MoshrefUi/dataProcessScreen/screen.dart';
import 'package:masjed/MoshrefUi/drawer/drawer.dart';
import 'package:masjed/MoshrefUi/examSuccessAdding/examSuccessAdding.dart';
import 'package:masjed/MoshrefUi/history/historyShape.dart';
import 'package:masjed/generalBottomBar.dart';
import 'package:masjed/model/ExamModel.dart';
import 'package:masjed/provider.dart';
import 'package:provider/provider.dart';

import '../../appBar.dart';
import '../../bottomBar.dart';
import '../../lists.dart';
import '../../main.dart';
class ExamDataShow extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
BuildContext cont;
  @override
  Widget build(BuildContext context) {
    cont=context;
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: appBar(),
      ),
      body: body(),
      endDrawer: DrawerApp(),
      endDrawerEnableOpenDragGesture: false,
      bottomNavigationBar: GeneralBottomBar(Screen(chains, "الحلقات القرانية")),

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
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('exams').snapshots();

    return Consumer<ProviderMasjed>(
      builder:(context,ProviderMasjed,x)=> Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("ارشيف الاختبارات",style: TextStyle(fontSize: 20,color: Colors.black),),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              HistoryShape("م.", "اسم الطالب", "الجزء المختبر", Colors.white,mainColor,(){},(){}),
              StreamBuilder<QuerySnapshot>(
                stream: _usersStream,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  int count=0;
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return snapshot.data.docs.length==0?Container(alignment: Alignment.center,child: Text("لا يوجد اختبارات",style: TextStyle(color: mainColor,fontSize: 20),),):Column(
                    children: snapshot.data.docs.map((DocumentSnapshot document) {
                      int num=++count;
                      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                      return HistoryShape(num.toString(), data['studentName'], data['examName'], Colors.black,Colors.white,(){
                        Exam_model exam=Exam_model.fromMap(data);
                        print(exam.studentName);
                        ProviderMasjed.getPressedExam(exam);
                        Navigator.of(cont).pushReplacement(
                            MaterialPageRoute(
                                builder: (con) => ExamSuccessAdding(ExamDataShow(),DrawerApp())));
                      },(){
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                  backgroundColor:mainColor,
                                  actions: [
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(onPressed: (){
                                            FirebaseFirestore.instance
                                                .collection("exams")
                                                .where("examName", isEqualTo : data["examName"])
                                                .where("studentName", isEqualTo : data["studentName"])
                                                .get().then((value){
                                              value.docs.forEach((element) {
                                                FirebaseFirestore.instance.collection("exams").doc(element.id).delete().then((value){
                                                  print("Success!");
                                                });
                                              });
                                            });
                                            Navigator.of(context).pop();
                                          },style: TextButton.styleFrom(
                                            primary: Colors.white,
                                            backgroundColor: Colors.white,
                                          ), child: Text("تاكيد",style: TextStyle(color: Colors.black,fontSize: 16),)),

                                          TextButton(onPressed: (){
                                            Navigator.of(context).pop();
                                          }, style: TextButton.styleFrom(
                                            primary: Colors.white,
                                            backgroundColor: Colors.white,
                                          ),child: Text("تراجع",style: TextStyle(color: Colors.black,fontSize: 16),)),
                                        ],
                                      ),
                                    )
                                  ],
                                  content:Container(
                                      height: 80,
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.zero,
                                      child: Text("هل تريد حذف الحلقة؟",style: TextStyle(color: Colors.white,fontSize: 18),))

                              );
                            });
                      });
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
