import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:masjed/MoshrefUi/DailyHefthShow/dailyHefthShow.dart';
import 'package:masjed/MoshrefUi/dailyhefth/hefthShape.dart';
import 'package:masjed/MoshrefUi/drawer/drawer.dart';
import 'package:masjed/MoshrefUi/history/historyButton.dart';
import 'package:masjed/MoshrefUi/historyHefth/historyHefth.dart';
import 'package:masjed/MoshrefUi/historyOfDailyHefth/historyOfDailyHefth.dart';
import 'package:masjed/generalBottomBar.dart';
import 'package:masjed/model/HefthModel.dart';
import 'package:masjed/provider.dart';
import 'package:provider/provider.dart';

import '../../appBar.dart';
import '../../bottomBar.dart';
import '../../main.dart';
class StudentHefth extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  BuildContext context;
  @override
  Widget build(BuildContext cont) {
    context=cont;
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: appBar(),
      ),

      body: body(),
      endDrawer: DrawerApp(),
      endDrawerEnableOpenDragGesture: false,
      bottomNavigationBar: GeneralBottomBar(HistoryOfDailyHefth()),
    );
  }
  /*************appBar**********/
  Widget appBar() {
    return AppBarCustom(
      "ارشيف الحفظ اليومي",
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
  /*************bottomBar**********/
  Widget body(){
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('reports').snapshots();
    return Consumer<ProviderMasjed>(
      builder:(context,ProviderMasjed,x)=> SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HistoryButton(
                    "تاريخ الحفظ اليومي", 300, Colors.white, mainColor, () {},(){}),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: snapshot.data.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                        if(data['studentNameHefth']==ProviderMasjed.pressedStudent.studentName){
                          return Column(
                              children: [
                                HistoryButton( data['date'],300, mainColor,Colors.white,(){
                                  ProviderMasjed.pressedHistory=Hefth_Model.fromMap(data);
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (con) =>HistoryHefth(StudentHefth(),DrawerApp())));
                                },(){}),
                              ]

                          );

                        }else{
                          return SizedBox.shrink(child: Text("لا يوجد نتائج"),);
                        }


                      }).toList(),
                    );



                  },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
