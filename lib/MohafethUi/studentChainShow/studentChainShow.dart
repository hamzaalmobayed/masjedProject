import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:masjed/MoshrefUi/dataProcessScreen/screen.dart';
import 'package:masjed/MoshrefUi/drawer/drawer.dart';
import 'package:masjed/MoshrefUi/history/historyShape.dart';
import 'package:masjed/MoshrefUi/studentDataView.dart';
import 'package:masjed/MoshrefUi/studentSuccessAdding/StudentSuccessAdding.dart';
import 'package:masjed/generalBottomBar.dart';
import 'package:masjed/model/StudentModel.dart';
import 'package:masjed/provider.dart';
import 'package:provider/provider.dart';

import '../../appBar.dart';
import '../../bottomBar.dart';
import '../../main.dart';
import '../../lists.dart';
class StudentChainShow extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget back;
  Widget drawer;

  StudentChainShow(this.back, this.drawer);

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
      endDrawer: drawer,
      endDrawerEnableOpenDragGesture: false,
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
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('students').snapshots();
    return Consumer<ProviderMasjed>(
      builder: (context,ProviderMasjed,x)=>Padding(
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
                    Text("بيانات الطلاب",style: TextStyle(fontSize: 20,color: Colors.black),),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              HistoryShape("م.", "اسم الطالب", "رقم الجوال", Colors.white,mainColor,(){},(){}),
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

                  return snapshot.data.docs.length==0?Container(alignment: Alignment.center,child: Text("لا يوجد طلاب",style: TextStyle(color: mainColor,fontSize: 20),),):Column(
                    children: snapshot.data.docs.map((DocumentSnapshot document) {
                      int num=++count;
                      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                    if(ProviderMasjed.pressedChainShow.chainName==data['chainName']){
                      return HistoryShape(num.toString(), data["studentName"], data["mobile"], Colors.black,Colors.white,(){
                      },(){}
                      );
                    }else{return SizedBox.shrink();};
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
