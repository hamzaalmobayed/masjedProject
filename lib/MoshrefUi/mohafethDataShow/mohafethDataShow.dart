import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:masjed/MohafethUi/mohafethDataShow/mohafethDataView.dart';
import 'package:masjed/MoshrefUi/dataProcessScreen/screen.dart';
import 'package:masjed/MoshrefUi/drawer/drawer.dart';
import 'package:masjed/MoshrefUi/history/historyShape.dart';
import 'package:masjed/MoshrefUi/mohafethSuccessAdding/mohafethSuccessAdding.dart';
import 'package:masjed/MoshrefUi/moshref/Moshref.dart';
import 'package:masjed/generalBottomBar.dart';
import 'package:masjed/model/MohafethModel.dart';
import 'package:masjed/provider.dart';
import 'package:provider/provider.dart';

import '../../appBar.dart';
import '../../bottomBar.dart';
import '../../main.dart';
import '../../lists.dart';
class MohafethDataShow extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
      endDrawer: DrawerApp(),
      endDrawerEnableOpenDragGesture: false,
      bottomNavigationBar: GeneralBottomBar(Screen(mohafez, "بيانات المحفظين")),

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
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('mohafeths').snapshots();
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
                    Text("بيانات المحفظين",style: TextStyle(fontSize: 20,color: Colors.black),),
                  ],
                ),
              ),
              SizedBox(height: 20,),
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

                return snapshot.data.docs.length==0?Container(alignment: Alignment.center,child: Text("لا يوجد محفظين",style: TextStyle(color: mainColor,fontSize: 20),),):Column(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    int num=++count;
                    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                    return HistoryShape(num.toString(), data["mohafethName"], data["mobile"], Colors.black,Colors.white,(){
                      ProviderMasjed.getPressedMohafeth(Mohafeth_model.fromMap(data));
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (con) => MohafethDataView(MohafethDataShow(),DrawerApp())));
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
                                              .collection("mohafeths")
                                              .where("mohafethIdCard", isEqualTo : data["mohafethIdCard"])
                                              .get().then((value){
                                            value.docs.forEach((element) {
                                              FirebaseFirestore.instance.collection("mohafeths").doc(element.id).delete().then((value){
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
                    });
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
