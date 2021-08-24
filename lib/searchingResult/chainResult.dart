import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:masjed/MoshrefUi/drawer/drawer.dart';
import 'package:masjed/MoshrefUi/moshref/Moshref.dart';
import 'package:masjed/MoshrefUi/myData/dataPlace.dart';
import 'package:masjed/appBar.dart';
import 'package:masjed/generalBottomBar.dart';
import 'package:masjed/main.dart';

import 'package:masjed/nameData.dart';
import 'package:masjed/provider.dart';
import 'package:provider/provider.dart';

import '../../bottomBar.dart';
class ChainResult extends StatefulWidget {
  Widget widget;
  Widget drawer;

  ChainResult(this.widget,this.drawer);

  @override
  _ChainResultState createState() => _ChainResultState();
}

class _ChainResultState extends State<ChainResult> {
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
      endDrawer:widget.drawer,
      endDrawerEnableOpenDragGesture: false,
      bottomNavigationBar: GeneralBottomBar(widget.widget),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: floatingButton(),
    );
  }

  /*************appBar**********/
  Widget appBar() {
    return AppBarCustom(
      "بيانات الحلقة",
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
    return Padding(
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
          },
          child: Icon(Icons.edit,color: Colors.white,size: 30,),
        ),
      ),
    );
  }
  /*************body**********/
  Widget body(){
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('chains').snapshots();
    return Consumer<ProviderMasjed>(
        builder:(context,ProviderMasjed,x)=> SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top:20.0,left: 10,right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                NameInAddingData(ImageIcon(
                  AssetImage("images/group.png"),
                  color: Colors.black,
                  size: 70,
                ), read, enable, "اسم الحلقة", ProviderMasjed.chainNameCon.text,con1),
                SizedBox(height: 20,),
                DataPlace("محفظ الحلقة", con1, "زكريا ابو كميل", read, enable),
                DataPlace("المحفظ المساعد", con1, "انس عماد حبوب", read, enable),
                DataPlace("الفئة العمرية", con1, "المرحلة الابتدائية", read, enable),
                DataPlace("عدد الطلاب", con1, ProviderMasjed.chainNumberCon.text, read, enable),

              ],
            ),
          ),
        )
    );
  }

}
