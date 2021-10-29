import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:masjed/MoshrefUi/drawer/drawer.dart';
import 'package:masjed/MoshrefUi/hafethAdding/hafethAdding.dart';
import 'package:masjed/MoshrefUi/hafethDataView/hafethDataView.dart';
import 'package:masjed/MoshrefUi/history/historyShape.dart';
import 'package:masjed/MoshrefUi/moshref/Moshref.dart';
import 'package:masjed/generalBottomBar.dart';
import 'package:masjed/model/HafethModel.dart';
import 'package:provider/provider.dart';

import '../../appBar.dart';
import '../../bottomBar.dart';
import '../../main.dart';
import '../../provider.dart';
class History extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
BuildContext cont;
  @override
  Widget build(BuildContext context) {
    cont=context;
    return Scaffold(
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
      floatingActionButton:floatingButton(),
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
  /*************floatingButton**********/
  Widget floatingButton(){
    return Padding(
    padding: const EdgeInsets.only(top: 80.0),
    child: CircleAvatar(
    backgroundColor: Colors.white,
    radius: 35,
    child: FloatingActionButton(
    backgroundColor: mainColor,
    onPressed: (){
      Navigator.of(cont).push(MaterialPageRoute(builder: (con)=>HafethAdding()));
    },
    child: Icon(Icons.add,color: Colors.white,size: 30,),
    ),
    ),
    );
  }
  /*************bottomBar**********/
  Widget body(){
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('hafeth').snapshots();
    return Consumer<ProviderMasjed>(
      builder: (context,ProviderMasjed,x)=>Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("سجل الحفاظ",style: TextStyle(fontSize: 20,color: Colors.black),),
                    Icon(Icons.assessment,color: Colors.black,size: 30,)
                  ],
                ),
              ),
              HistoryShape("م.", "اسم الحافظ", "رقم الجوال", Colors.white,mainColor,(){},(){}),
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

                  return snapshot.data.docs.length==0?Container(alignment: Alignment.center,child: Text("لا يوجد حفاظ",style: TextStyle(color: mainColor,fontSize: 20),),):Column(
                    children: snapshot.data.docs.map((DocumentSnapshot document) {
                      int num=++count;
                      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                      return HistoryShape(num.toString(), data['hafethName'], data['mobile'], mainColor,Colors.white,(){
                        ProviderMasjed.getPressedHafeth(Hafeth_model.fromMap(data));
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (con) => HafethDataView(History(),DrawerApp())));
                      },(){
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                  backgroundColor:mainColor,
                                  actions: [
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(onPressed: (){
                                            FirebaseFirestore.instance
                                                .collection("hafeth")
                                                .where("hafethIdCard", isEqualTo : data["hafethIdCard"])
                                                .get().then((value){
                                              value.docs.forEach((element) {
                                                FirebaseFirestore.instance.collection("hafeth").doc(element.id).delete().then((value){
                                                  print("Success!");
                                                });
                                              });
                                            });
                                            FirebaseFirestore.instance
                                                .collection("coming")
                                                .where("name", isEqualTo : data["mohafethName"])
                                                .get().then((value){
                                              value.docs.forEach((element) {
                                                FirebaseFirestore.instance.collection("coming").doc(element.id).delete().then((value){
                                                  print("Success!");
                                                });
                                              });
                                            });
                                            Navigator.of(context).pop();
                                          },style: TextButton.styleFrom(
                                            primary: Colors.white,
                                            backgroundColor: Colors.white,
                                          ), child: Text("تاكيد",style: TextStyle(color: Colors.black,fontSize: 16),)),

                                          TextButton(onPressed: (){
                                            Navigator.of(context).pop();
                                          }, style: TextButton.styleFrom(
                                            primary: Colors.white,
                                            backgroundColor: Colors.white,
                                          ),child: Text("تراجع",style: TextStyle(color: Colors.black,fontSize: 16),)),
                                        ],
                                      ),
                                    )
                                  ],
                                  content:Container(
                                      height: 80,
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.zero,
                                      child: Text("هل تريد حذف المحفظ؟",style: TextStyle(color: Colors.white,fontSize: 18),))

                              );
                            });
                      }
                      )
                      ;
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
