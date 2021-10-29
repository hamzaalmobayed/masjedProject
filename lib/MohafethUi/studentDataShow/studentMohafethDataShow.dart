import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:masjed/MoshrefUi/dataProcessScreen/screen.dart';
import 'package:masjed/MoshrefUi/drawer/drawer.dart';
import 'package:masjed/MoshrefUi/history/historyShape.dart';
import 'package:masjed/MoshrefUi/studentSuccessAdding/StudentSuccessAdding.dart';
import 'package:masjed/generalBottomBar.dart';
import 'package:masjed/provider.dart';
import 'package:provider/provider.dart';

import '../../appBar.dart';
import '../../bottomBar.dart';
import '../../main.dart';
import '../../lists.dart';
class StudentMohafethDataShow extends StatefulWidget {
  Widget back;
  Widget drawer;

  StudentMohafethDataShow(this.back, this.drawer);

  @override
  _StudentMohafethDataShowState createState() => _StudentMohafethDataShowState();
}

class _StudentMohafethDataShowState extends State<StudentMohafethDataShow> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  BuildContext context;

  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1),(){
      Provider.of<ProviderMasjed>(context,listen: false).getMohafethChainFromFirestore();

      Provider.of<ProviderMasjed>(context,listen: false).getStudentChainFromFirestore();
    });
  }

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
      endDrawer: widget.drawer,
      endDrawerEnableOpenDragGesture: false,
      bottomNavigationBar: GeneralBottomBar(widget.back),

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
    int coun=0;
    int num;
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
                    Text("بيانات الطلاب",style: TextStyle(fontSize: 20,color: Colors.black),),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              HistoryShape("م.", "اسم الطالب", "رقم الجوال", Colors.white,mainColor,(){},(){}),
              Column(
                  children: ProviderMasjed.studentChain.map((e){
                    num=coun+1;
                    return HistoryShape(num.toString(), e.studentName, e.mobile, Colors.black,Colors.white,(){
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (con) => StudentSuccessAdding(StudentMohafethDataShow(widget.back,widget.drawer),widget.drawer)));
                    },(){});
                  }).toList()
              )

            ],
          ),
        ),
      ),
    );
  }
}
