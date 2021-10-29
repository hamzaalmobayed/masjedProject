import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:masjed/MoshrefUi/drawer/drawer.dart';
import 'package:masjed/MoshrefUi/historyOfDailyHefth/historyOfDailyHefth.dart';
import 'package:masjed/MoshrefUi/moshref/Moshref.dart';
import 'package:masjed/generalBottomBar.dart';
import 'package:masjed/model/ChainModel.dart';
import 'package:masjed/provider.dart';
import 'package:provider/provider.dart';

import '../../appBar.dart';
import '../../bottomBar.dart';
import '../../main.dart';
import 'hefthShape.dart';
class Hefth extends StatelessWidget {
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
    );
  }
  /*************appBar**********/
  Widget appBar() {
    return AppBarCustom(
      "ارشيف الحفظ اليومي",
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
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('chains').snapshots();
    int count=1;
    return Consumer<ProviderMasjed>(
      builder:(context,ProviderMasjed,x)=> SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            children: [
              HefthShape("م.", "اسم الحلقة",  Colors.white,mainColor,(){},(){},(){}),
            StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                      return Column(
                        children: [
                          HefthShape((count++).toString(), data['chainName'], mainColor,Colors.white,(){
                            print('done');
                            ProviderMasjed.pressedChain=Chain_model.fromMap(data);
                            Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                    builder: (con) => HistoryOfDailyHefth()));
                    },(){},(){})
                        ]

                      );


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
