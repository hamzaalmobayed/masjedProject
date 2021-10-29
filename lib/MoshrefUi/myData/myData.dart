import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:masjed/appBar.dart';
import 'package:masjed/MoshrefUi/drawer/drawer.dart';
import 'package:masjed/generalBottomBar.dart';
import 'package:masjed/main.dart';
import 'package:masjed/MoshrefUi/moshref/Moshref.dart';
import 'package:masjed/MoshrefUi/myData/dataPlace.dart';
import 'package:masjed/nameData.dart';

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
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('moshref').snapshots();
    return SingleChildScrollView(
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
                        NameInAddingData(Icon(Icons.account_circle_outlined,size: 100,color: Colors.black,), read, enable, "الاسم", data["moshrefName"],con1,(v){}),
                        SizedBox(height: 20,),
                        DataPlace("رقم الهوية", con1,data["moshrefIdCard"], read, enable),
                        DataPlace("تاريخ الميلاد", con1,data['birthDate'], read, enable),
                        DataPlace("التخصص الاكاديمي", con1, data['feild'], read, enable),
                        DataPlace("رقم الجوال", con1, data['mobile'], read, enable),
                        DataPlace("رتبة العمل", con1, data['job'], read, enable),
                        DataPlace("حالة الاسرة", con1, data['familyStatus'], read, enable),
                      ],
                    );
                  }).toList(),
                );
              },
            ),

          ],
        ),
      ),
    );
  }


}
