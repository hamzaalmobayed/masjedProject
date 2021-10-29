import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:masjed/appBar.dart';
import 'package:masjed/MoshrefUi/drawer/drawer.dart';
import 'package:masjed/generalBottomBar.dart';
import 'package:masjed/main.dart';
import 'package:masjed/MoshrefUi/mohafethAdding/mohafethAdding.dart';
import 'package:masjed/MoshrefUi/moshref/Moshref.dart';
import 'package:masjed/MoshrefUi/myData/dataPlace.dart';
import 'package:masjed/model/MohafethModel.dart';
import 'package:masjed/nameData.dart';
import 'package:masjed/provider.dart';
import 'package:provider/provider.dart';

import '../../bottomBar.dart';

class MohafethDataView extends StatefulWidget {
  Widget widget;
  Widget drawer;

  MohafethDataView(this.widget, this.drawer);

  @override
  _MohafethDataViewState createState() => _MohafethDataViewState();
}

class _MohafethDataViewState extends State<MohafethDataView> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool enable = false;

  bool read = true;
  TextEditingController con1 = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<ProviderMasjed>(context,listen: false).mohafethNameCon2.text= Provider.of<ProviderMasjed>(context,listen: false).pressedMohafeth.mohafethName;
    Provider.of<ProviderMasjed>(context,listen: false).CardCon2.text= Provider.of<ProviderMasjed>(context,listen: false).pressedMohafeth.mohafethIdCard;
    Provider.of<ProviderMasjed>(context,listen: false).mohafethBirthdayCon2.text= Provider.of<ProviderMasjed>(context,listen: false).pressedMohafeth.birthDate;
    Provider.of<ProviderMasjed>(context,listen: false).mohafethFeildCon2.text= Provider.of<ProviderMasjed>(context,listen: false).pressedMohafeth.feild;
    Provider.of<ProviderMasjed>(context,listen: false).mohafethMobileCon2.text= Provider.of<ProviderMasjed>(context,listen: false).pressedMohafeth.mobile;
    Provider.of<ProviderMasjed>(context,listen: false).mohafethStatusCon2.text= Provider.of<ProviderMasjed>(context,listen: false).pressedMohafeth.familyStatus;
    Provider.of<ProviderMasjed>(context,listen: false).mohafethPasswordCon2.text= Provider.of<ProviderMasjed>(context,listen: false).pressedMohafeth.password;
    Provider.of<ProviderMasjed>(context,listen: false).mohafethCourseCon2.text= Provider.of<ProviderMasjed>(context,listen: false).pressedMohafeth.course;
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
              String mohafethUpdate="";
              setState(() {
                enable=!enable;
                read=!read;
              });
              if(enable==true){
                mohafethUpdate=ProviderMasjed.mohafethNameCon2.text;
              }
              if(enable==false){
                Mohafeth_model mohafeth=Mohafeth_model(
                  mohafethName:ProviderMasjed.mohafethNameCon2.text,
                  mohafethIdCard:ProviderMasjed.CardCon2.text,
                  birthDate:ProviderMasjed.mohafethBirthdayCon2.text,
                  feild:ProviderMasjed.mohafethFeildCon2.text,
                  mobile:ProviderMasjed.mohafethMobileCon2.text,
                  familyStatus:ProviderMasjed.mohafethStatusCon2.text,
                  password:ProviderMasjed.mohafethPasswordCon2.text,
                  course:ProviderMasjed.mohafethCourseCon2.text,
                );
                print(mohafethUpdate+'//////////');
                FirebaseFirestore.instance
                    .collection("coming")
                    .where("name", isEqualTo : ProviderMasjed.pressedMohafeth.mohafethName)
                    .get().then((value){
                  value.docs.forEach((element) {
                    FirebaseFirestore.instance.collection("coming").doc(element.id).update(
                        {"name":ProviderMasjed.mohafethNameCon2.text}).then((value){
                      print("Success coming!");
                    });
                  });
                });
                FirebaseFirestore.instance
                    .collection("messages")
                    .where("sender", isEqualTo : ProviderMasjed.pressedMohafeth.mohafethName)
                    .get().then((value){
                  value.docs.forEach((element) {
                    FirebaseFirestore.instance.collection("messages").doc(element.id).update(
                        {"sender":ProviderMasjed.mohafethNameCon2.text}).then((value){
                      print("Success sender!");
                    });
                  });
                });
                FirebaseFirestore.instance
                    .collection("messages")
                    .where("receiver", isEqualTo : ProviderMasjed.pressedMohafeth.mohafethName)
                    .get().then((value){
                  value.docs.forEach((element) {
                    FirebaseFirestore.instance.collection("messages").doc(element.id).update(
                        {"receiver":ProviderMasjed.mohafethNameCon2.text}).then((value){
                      print("Success receiver!");
                    });
                  });
                });
                FirebaseFirestore.instance
                    .collection("mohafeths")
                    .where("mohafethIdCard", isEqualTo : ProviderMasjed.pressedMohafeth.mohafethIdCard)
                    .get().then((value){
                  value.docs.forEach((element) {
                    FirebaseFirestore.instance.collection("mohafeths").doc(element.id).update(mohafeth.toMap()).then((value){
                      print("Success mohafeth!");
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
                    ProviderMasjed.pressedMohafeth.mohafethName,
                    ProviderMasjed.mohafethNameCon2,
                    (v) {}),
                SizedBox(
                  height: 20,
                ),
                DataPlace("رقم الهوية",ProviderMasjed.CardCon2,
                    ProviderMasjed.pressedMohafeth.mohafethIdCard, read, enable),
                DataPlace("تاريخ الميلاد", ProviderMasjed.mohafethBirthdayCon2,
                    ProviderMasjed.pressedMohafeth.birthDate, read, enable),
                DataPlace("التخصص الاكاديمي", ProviderMasjed.mohafethFeildCon2,
                    ProviderMasjed.pressedMohafeth.feild, read, enable),
                DataPlace("رقم الجوال", ProviderMasjed.mohafethMobileCon2,
                    ProviderMasjed.pressedMohafeth.mobile, read, enable),
                DataPlace("حالة الاسرة", ProviderMasjed.mohafethStatusCon2,
                    ProviderMasjed.pressedMohafeth.familyStatus, read, enable),
                DataPlace("كلمة المرور", ProviderMasjed.mohafethPasswordCon2,
                    ProviderMasjed.pressedMohafeth.password, read, enable),
                DataPlace("اخر دورة احكام",ProviderMasjed.mohafethCourseCon2 ,
                    ProviderMasjed.pressedMohafeth.course, read, enable),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
