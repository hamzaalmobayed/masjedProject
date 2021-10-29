import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:masjed/appBar.dart';
import 'package:masjed/MoshrefUi/drawer/drawer.dart';
import 'package:masjed/generalBottomBar.dart';
import 'package:masjed/main.dart';
import 'package:masjed/MoshrefUi/mohafethAdding/mohafethAdding.dart';
import 'package:masjed/MoshrefUi/moshref/Moshref.dart';
import 'package:masjed/MoshrefUi/myData/dataPlace.dart';
import 'package:masjed/model/HafethModel.dart';
import 'package:masjed/model/MohafethModel.dart';
import 'package:masjed/nameData.dart';
import 'package:masjed/provider.dart';
import 'package:provider/provider.dart';

import '../../bottomBar.dart';
class HafethResult extends StatefulWidget {
  Widget widget;
  Widget drawer;

  HafethResult(this.widget,this.drawer);

  @override
  _HafethResultState createState() => _HafethResultState();
}

class _HafethResultState extends State<HafethResult> {
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
    return Consumer<ProviderMasjed>(
      builder:(context,ProviderMasjed,x)=> Padding(
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
              if(enable==false){
                Hafeth_model mohafeth=Hafeth_model(
                  hafethName:ProviderMasjed.hafethNameCon1.text,
                  hafethIdCard:ProviderMasjed.hafethCardCon1.text,
                  birthDate:ProviderMasjed.hafethBirthdayCon1.text,
                  feild:ProviderMasjed.hafethFeildCon1.text,
                  mobile:ProviderMasjed.hafethMobileCon1.text,
                  familyStatus:ProviderMasjed.hafethStatusCon1.text==null?ProviderMasjed.selectedStatus:ProviderMasjed.mohafethStatusCon1.text,
                  mohafethName:ProviderMasjed.hafethMohafethCon1.text,
                  course:ProviderMasjed.hafethCourseCon1.text==null?ProviderMasjed.selectedCourse:ProviderMasjed.mohafethCourseCon1.text,
                  hefthDate:ProviderMasjed.hafethDateCon1.text,
                  hefthStatus:ProviderMasjed.hafethCourseCon1.text==null?ProviderMasjed.selectedHefthStatus:ProviderMasjed.hafethHefthCon1.text,
                );
                FirebaseFirestore.instance
                    .collection("hafeths")
                    .where("hafethIdCard", isEqualTo : ProviderMasjed.hafethCardCon1.text)
                    .get().then((value){
                  value.docs.forEach((element) {
                    FirebaseFirestore.instance.collection("hafeths").doc(element.id).update(mohafeth.toMap()).then((value){
                      print("Success!");
                    });
                  });
                });
              }
            },
            child: Icon(Icons.edit,color: Colors.white,size: 30,),
          ),
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
              NameInAddingData(Icon(Icons.account_circle_outlined,size: 100,color: Colors.black,), read, enable, "اسم المحفظ",ProviderMasjed.mohafethNameCon.text,ProviderMasjed.hafethNameCon1,(v){}),
              SizedBox(height: 20,),
              DataPlace("رقم الهوية", ProviderMasjed.hafethCardCon1, ProviderMasjed.CardCon.text, read, enable),
              DataPlace("تاريخ الميلاد", ProviderMasjed.hafethBirthdayCon1, ProviderMasjed.mohafethBirthdayCon.text, read, enable),
              DataPlace("التخصص الاكاديمي", ProviderMasjed.hafethFeildCon1, ProviderMasjed.mohafethFeildCon.text, read, enable),
              DataPlace("رقم الجوال", ProviderMasjed.hafethMobileCon1, ProviderMasjed.mohafethMobileCon.text, read, enable),
              DataPlace("حالة الاسرة",ProviderMasjed.hafethStatusCon1 ,ProviderMasjed.selectedStatus, read, enable),
              DataPlace("كلمة المرور", ProviderMasjed.hafethMohafethCon1, ProviderMasjed.hafethMohafethCon1.text, read, enable),
              DataPlace("اخر دورة احكام", ProviderMasjed.hafethCourseCon1,ProviderMasjed.selectedCourse, read, enable),
              DataPlace("اخر دورة احكام", ProviderMasjed.hafethDateCon1,ProviderMasjed.hafethDateCon1.text, read, enable),
              DataPlace("اخر دورة احكام", ProviderMasjed.hafethHefthCon1,ProviderMasjed.selectedHefthStatus, read, enable),

            ],
          ),
        ),
      ),
    );
  }


}
