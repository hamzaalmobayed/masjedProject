import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:masjed/MoshrefUi/StudentHefth/studentHefth.dart';
import 'package:masjed/MoshrefUi/dailyhefth/hefth.dart';
import 'package:masjed/MoshrefUi/dailyhefth/hefthShape.dart';
import 'package:masjed/MoshrefUi/drawer/drawer.dart';
import 'package:masjed/MoshrefUi/history/historyButton.dart';
import 'package:masjed/generalBottomBar.dart';
import 'package:masjed/model/StudentModel.dart';
import 'package:masjed/provider.dart';
import 'package:provider/provider.dart';
import '../../appBar.dart';
import '../../bottomBar.dart';
import '../../main.dart';

class HistoryOfDailyHefth extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  BuildContext context;

  @override
  Widget build(BuildContext cont) {
    context = cont;
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: appBar(),
      ),
      body: body(),
      endDrawer: DrawerApp(),
      endDrawerEnableOpenDragGesture: false,
      bottomNavigationBar: GeneralBottomBar(Hefth()),
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
  Widget body() {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('students').snapshots();
    int count = 1;
    return Consumer<ProviderMasjed>(
      builder: (context, ProviderMasjed, x) => SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 30,
              ),

              HefthShape("م.", "اسم الطالب",  Colors.white,mainColor,(){},(){},(){}),
            StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

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
                    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                    if(data['chainName']==ProviderMasjed.pressedChain.chainName){
                      return Column(
                          children: [
                            HefthShape((count++).toString(),
                                data['studentName'], mainColor, Colors.white, () {
                                  ProviderMasjed.pressedStudent=Student_model.fromMap(data);
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (con) => StudentHefth()));
                                },(){},(){})
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
    );
  }
}
