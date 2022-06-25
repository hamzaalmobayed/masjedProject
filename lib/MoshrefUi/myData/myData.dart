import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:masjed/appBar.dart';
import 'package:masjed/MoshrefUi/drawer/drawer.dart';
import 'package:masjed/generalBottomBar.dart';
import 'package:masjed/main.dart';
import 'package:masjed/MoshrefUi/moshref/Moshref.dart';
import 'package:masjed/MoshrefUi/myData/dataPlace.dart';
import 'package:masjed/model/MoshrefModel.dart';
import 'package:masjed/nameData.dart';
import 'package:masjed/provider.dart';
import 'package:provider/provider.dart';

import '../../bottomBar.dart';
class MyData extends StatefulWidget {
  @override
  _MyDataState createState() => _MyDataState();
}

class _MyDataState extends State<MyData> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool enable=false;

  bool read=true;
TextEditingController con1=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProviderMasjed>(context,listen: false).moshrefNameCon.text=Provider.of<ProviderMasjed>(context,listen: false).allMoshref.first.moshrefName;
    Provider.of<ProviderMasjed>(context,listen: false).moshrefpasswordCon.text=Provider.of<ProviderMasjed>(context,listen: false).allMoshref.first.password;
    Provider.of<ProviderMasjed>(context,listen: false).moshrefbirthDateCon.text=Provider.of<ProviderMasjed>(context,listen: false).allMoshref.first.birthDate;
    Provider.of<ProviderMasjed>(context,listen: false).moshreffamilyStatusCon.text=Provider.of<ProviderMasjed>(context,listen: false).allMoshref.first.familyStatus;
    Provider.of<ProviderMasjed>(context,listen: false).moshreffeildCon.text=Provider.of<ProviderMasjed>(context,listen: false).allMoshref.first.feild;
    Provider.of<ProviderMasjed>(context,listen: false).moshrefjobCon.text=Provider.of<ProviderMasjed>(context,listen: false).allMoshref.first.job;
    Provider.of<ProviderMasjed>(context,listen: false).moshrefmobileCon.text=Provider.of<ProviderMasjed>(context,listen: false).allMoshref.first.mobile;
    Provider.of<ProviderMasjed>(context,listen: false).moshrefIdCardCon.text=Provider.of<ProviderMasjed>(context,listen: false).allMoshref.first.moshrefIdCard;
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
      endDrawer: DrawerApp(),
      endDrawerEnableOpenDragGesture: false,
      bottomNavigationBar: GeneralBottomBar(Moshref()),
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
              String moshrefUpdate="";
              setState(() {
                enable=!enable;
                read=!read;
              });
              if(enable==true){
                moshrefUpdate=ProviderMasjed.moshrefNameCon.text;
              }
              if(enable==false){
                Moshref_model moshref=Moshref_model(
                  birthDate: ProviderMasjed.moshrefbirthDateCon.text,
                  familyStatus:ProviderMasjed.moshreffamilyStatusCon.text ,
                  feild: ProviderMasjed.moshreffeildCon.text,
                  job: ProviderMasjed.moshrefjobCon.text,
                  mobile: ProviderMasjed.moshrefmobileCon.text,
                  moshrefIdCard: ProviderMasjed.moshrefIdCardCon.text,
                  moshrefName: ProviderMasjed.moshrefNameCon.text ,
                  password: ProviderMasjed.moshrefpasswordCon.text,
                );
                print(moshrefUpdate+'//////////');
                FirebaseFirestore.instance
                    .collection("coming")
                    .where("name", isEqualTo : ProviderMasjed.allMoshref.first.moshrefName)
                    .get().then((value){
                  value.docs.forEach((element) {
                    FirebaseFirestore.instance.collection("coming").doc(element.id).update(
                        {"name":ProviderMasjed.moshrefNameCon.text}).then((value){
                      print("Success coming!");
                    });
                  });
                });
                FirebaseFirestore.instance
                    .collection("messages")
                    .where("sender", isEqualTo :  ProviderMasjed.allMoshref.first.moshrefName)
                    .get().then((value){
                  value.docs.forEach((element) {
                    FirebaseFirestore.instance.collection("messages").doc(element.id).update(
                        {"sender":ProviderMasjed.moshrefNameCon.text}).then((value){
                      print("Success sender!");
                    });
                  });
                });
                FirebaseFirestore.instance
                    .collection("messages")
                    .where("receiver", isEqualTo :  ProviderMasjed.allMoshref.first.moshrefName)
                    .get().then((value){
                  value.docs.forEach((element) {
                    FirebaseFirestore.instance.collection("messages").doc(element.id).update(
                        {"receiver":ProviderMasjed.moshrefNameCon.text}).then((value){
                      print("Success receiver!");
                    });
                  });
                });
                FirebaseFirestore.instance
                    .collection("moshref")
                    .where("moshrefIdCard", isEqualTo : ProviderMasjed.allMoshref.first.moshrefIdCard)
                    .get().then((value){
                  value.docs.forEach((element) {
                    FirebaseFirestore.instance.collection("moshref").doc(element.id).update(moshref.toMap()).then((value){
                      print("Success moshref!");
                    });
                  });
                });
                ProviderMasjed.allMoshref.removeAt(0);
                ProviderMasjed.allMoshref.add(moshref);
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
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('moshref').snapshots();
    return Consumer<ProviderMasjed>(
        builder: (context, ProviderMasjed, x) => SingleChildScrollView(
        child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top:20.0,left: 10,right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
                    return Column(
                      children: [
                        NameInAddingData(Icon(Icons.account_circle_outlined,size: 100,color: Colors.black,), read, enable, "الاسم", data["moshrefName"],ProviderMasjed.moshrefNameCon,(v){}),
                        SizedBox(height: 20,),
                        DataPlace("رقم الهوية", ProviderMasjed.moshrefIdCardCon,'', read, enable),
                        DataPlace("تاريخ الميلاد", ProviderMasjed.moshrefbirthDateCon,'', read, enable),
                        DataPlace("التخصص الاكاديمي", ProviderMasjed.moshreffeildCon, '', read, enable),
                        DataPlace("رقم الجوال", ProviderMasjed.moshrefmobileCon, '', read, enable),
                        DataPlace("رتبة العمل", ProviderMasjed.moshrefjobCon,'', read, enable),
                        DataPlace("حالة الاسرة",  ProviderMasjed.moshreffamilyStatusCon, '', read, enable),
                        DataPlace("كلمة السر",  ProviderMasjed.moshrefpasswordCon, '', read, enable),
                      ],
                    );
                  }).toList(),
                );
              },
            ),

          ],
        ),
      ),
    ))
    );
  }


}
