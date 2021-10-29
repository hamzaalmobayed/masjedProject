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

class HafethDataView extends StatefulWidget {
  Widget widget;
  Widget drawer;

  HafethDataView(this.widget, this.drawer);

  @override
  _HafethDataViewState createState() => _HafethDataViewState();
}

class _HafethDataViewState extends State<HafethDataView> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool enable = false;

  bool read = true;
  TextEditingController con1 = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<ProviderMasjed>(context,listen: false).hafethNameCon2.text= Provider.of<ProviderMasjed>(context,listen: false).pressedHafeth.hafethName;
    Provider.of<ProviderMasjed>(context,listen: false).hafethCardCon2.text= Provider.of<ProviderMasjed>(context,listen: false).pressedHafeth.hafethIdCard;
    Provider.of<ProviderMasjed>(context,listen: false).hafethBirthdayCon2.text= Provider.of<ProviderMasjed>(context,listen: false).pressedHafeth.birthDate;
    Provider.of<ProviderMasjed>(context,listen: false).hafethFeildCon2.text= Provider.of<ProviderMasjed>(context,listen: false).pressedHafeth.feild;
    Provider.of<ProviderMasjed>(context,listen: false).hafethMobileCon2.text= Provider.of<ProviderMasjed>(context,listen: false).pressedHafeth.mobile;
    Provider.of<ProviderMasjed>(context,listen: false).hafethStatusCon2.text= Provider.of<ProviderMasjed>(context,listen: false).pressedHafeth.familyStatus;
    Provider.of<ProviderMasjed>(context,listen: false).hafethMohafethCon2.text= Provider.of<ProviderMasjed>(context,listen: false).pressedHafeth.mohafethName;
    Provider.of<ProviderMasjed>(context,listen: false).hafethCourseCon2.text= Provider.of<ProviderMasjed>(context,listen: false).pressedHafeth.course;
    Provider.of<ProviderMasjed>(context,listen: false).hafethHefthCon2.text= Provider.of<ProviderMasjed>(context,listen: false).pressedHafeth.hefthStatus;
    Provider.of<ProviderMasjed>(context,listen: false).hafethDateCon2.text= Provider.of<ProviderMasjed>(context,listen: false).pressedHafeth.hefthDate;
  }
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
      floatingActionButtonLocation:
      FloatingActionButtonLocation.miniCenterDocked,
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

  Widget floatingButton() {
    return  Consumer<ProviderMasjed>(
      builder:(context,ProviderMasjed,x)=> Padding(
        padding: const EdgeInsets.only(top: 80.0),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 35,
          child: FloatingActionButton(
            backgroundColor: mainColor,
            onPressed: (){
              String hafethUpdate;
              setState(() {
                enable=!enable;
                read=!read;
              });
              if(enable==true){
                hafethUpdate=ProviderMasjed.hafethNameCon2.text;
              }
              if(enable==false){
                Hafeth_model hafeth=Hafeth_model(
                  hafethName:ProviderMasjed.hafethNameCon2.text,
                  hafethIdCard:ProviderMasjed.hafethCardCon2.text,
                  birthDate:ProviderMasjed.hafethBirthdayCon2.text,
                  feild:ProviderMasjed.hafethFeildCon2.text,
                  mobile:ProviderMasjed.hafethMobileCon2.text,
                  familyStatus:ProviderMasjed.hafethStatusCon2.text,
                  mohafethName:ProviderMasjed.hafethMohafethCon2.text,
                  course:ProviderMasjed.hafethCourseCon2.text,
                  hefthDate:ProviderMasjed.hafethDateCon2.text ,
                  hefthStatus:ProviderMasjed.hafethHefthCon2.text
                );
                FirebaseFirestore.instance
                    .collection("hafeth")
                    .where("hafethIdCard", isEqualTo : hafethUpdate)
                    .get().then((value){
                  value.docs.forEach((element) {
                    FirebaseFirestore.instance.collection("hafeth").doc(element.id).update(hafeth.toMap()).then((value){
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
  Widget body() {
    return Consumer<ProviderMasjed>(
      builder: (context, ProviderMasjed, x) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 10, right: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                NameInAddingData(
                    Icon(
                      Icons.account_circle_outlined,
                      size: 100,
                      color: Colors.black,
                    ),
                    read,
                    enable,
                    "اسم المحفظ",
                    '',
                    ProviderMasjed.hafethNameCon2,
                        (v) {}),
                SizedBox(
                  height: 20,
                ),
                DataPlace("رقم الهوية",ProviderMasjed.hafethCardCon2,
                    ProviderMasjed.pressedHafeth.hafethIdCard, read, enable),
                DataPlace("تاريخ الميلاد", ProviderMasjed.hafethBirthdayCon2,
                    ProviderMasjed.pressedHafeth.birthDate, read, enable),
                DataPlace("التخصص الاكاديمي", ProviderMasjed.hafethFeildCon2,
                    ProviderMasjed.pressedHafeth.feild, read, enable),
                DataPlace("رقم الجوال", ProviderMasjed.hafethMobileCon2,
                    ProviderMasjed.pressedHafeth.mobile, read, enable),
                DataPlace("حالة الاسرة", ProviderMasjed.hafethStatusCon2,
                    ProviderMasjed.pressedHafeth.familyStatus, read, enable),
                DataPlace("كلمة المرور", ProviderMasjed.hafethMohafethCon2,
                    ProviderMasjed.pressedHafeth.mohafethName, read, enable),
                DataPlace("اخر دورة احكام",ProviderMasjed.hafethCourseCon2 ,
                    ProviderMasjed.pressedHafeth.course, read, enable),
                DataPlace("اخر دورة احكام",ProviderMasjed.hafethDateCon2 ,
                    ProviderMasjed.pressedHafeth.course, read, enable),
                DataPlace("اخر دورة احكام",ProviderMasjed.hafethHefthCon2 ,
                    ProviderMasjed.pressedHafeth.course, read, enable),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
