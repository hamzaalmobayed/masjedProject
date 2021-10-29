import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:masjed/MoshrefUi/drawer/drawer.dart';
import 'package:masjed/MoshrefUi/examSearchData/examResult.dart';
import 'package:masjed/MoshrefUi/examSearching/examSearching.dart';
import 'package:masjed/MoshrefUi/examSuccessAdding/examSuccessAdding.dart';
import 'package:masjed/generalBottomBar.dart';
import 'package:masjed/model/ExamModel.dart';
import 'package:masjed/provider.dart';
import 'package:provider/provider.dart';
import '../../appBar.dart';
import '../../bottomBar.dart';
import '../../main.dart';
import '../../nameData.dart';
class ExamSearchingData extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  BuildContext cont;
  TextEditingController con=TextEditingController();
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
      bottomNavigationBar: GeneralBottomBar(ExamSearching()),

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
      builder:(context,ProviderMasjed,x) =>Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              NameInAddingData(Text(""), false, true, "اسم الطالب ",ProviderMasjed.selectedChainStudent.studentName,con,(v){}),
              SizedBox(height: 20,),
              ExamResult("م.", "تاريخ الاختبار", "الجزء المختبر","العلامة", Colors.white,mainColor,(){},(){}),
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

                  return Column(
                    children: snapshot.data.docs.map((DocumentSnapshot document) {
                      int num=++count;
                      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                      String year=(data['examDate'] as String).split('/').last;
                      if(data['studentName']==ProviderMasjed.selectedChainStudent.studentName&&year==ProviderMasjed.selectedExamHistory.examDate.split('/').last){
                        return ExamResult(num.toString(), data['examDate'], data['examName'],data['grade'],mainColor, Colors.white,(){
                          Navigator.of(cont).pushReplacement(
                              MaterialPageRoute(
                                  builder: (con) => ExamSuccessAdding(ExamSearchingData(),DrawerApp())));
                        },(){});
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
