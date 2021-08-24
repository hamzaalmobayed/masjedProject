import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:masjed/appBar.dart';
import 'package:masjed/MoshrefUi/drawer/drawer.dart';
import 'package:masjed/generalBottomBar.dart';
import 'package:masjed/main.dart';
import 'package:masjed/MoshrefUi/mohafethAdding/mohafethAdding.dart';
import 'package:masjed/MoshrefUi/moshref/Moshref.dart';
import 'package:masjed/MoshrefUi/myData/dataPlace.dart';
import 'package:masjed/nameData.dart';
import 'package:masjed/provider.dart';
import 'package:provider/provider.dart';

import '../../bottomBar.dart';
class MohafethResult extends StatefulWidget {
  Widget widget;
  Widget drawer;

  MohafethResult(this.widget,this.drawer);

  @override
  _MohafethResultState createState() => _MohafethResultState();
}

class _MohafethResultState extends State<MohafethResult> {
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
      "بياناتي",
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
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('mohafeths').snapshots();
    return Consumer<ProviderMasjed>(
      builder:(context,ProviderMasjed,x)=> SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:20.0,left: 10,right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              NameInAddingData(Icon(Icons.account_circle_outlined,size: 100,color: Colors.black,), read, enable, "اسم المحفظ",ProviderMasjed.mohafethNameCon.text,con1),
              SizedBox(height: 20,),
              DataPlace("رقم الهوية", con1, ProviderMasjed.CardCon.text, read, enable),
              DataPlace("تاريخ الميلاد", con1, ProviderMasjed.mohafethBirthdayCon.text, read, enable),
              DataPlace("التخصص الاكاديمي", con1, ProviderMasjed.mohafethFeildCon.text, read, enable),
              DataPlace("رقم الجوال", con1, ProviderMasjed.mohafethMobileCon.text, read, enable),
              DataPlace("حالة الاسرة", con1,ProviderMasjed.mohafethStatus, read, enable),
              DataPlace("كلمة المرور", con1, ProviderMasjed.PasswordCon.text, read, enable),
              DataPlace("اخر دورة احكام", con1,ProviderMasjed.mohafethCourse, read, enable),

            ],
          ),
        ),
      ),
    );
  }


}
