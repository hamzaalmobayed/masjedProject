import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:masjed/MoshrefUi/drawer/drawer.dart';
import 'package:masjed/MoshrefUi/history/historyShape.dart';
import 'package:masjed/MoshrefUi/mohafethSearching/mohafethSearching.dart';
import 'package:masjed/generalBottomBar.dart';
import 'package:masjed/provider.dart';
import 'package:provider/provider.dart';
import '../../appBar.dart';
import '../../bottomBar.dart';
import '../../main.dart';
import '../../nameData.dart';
class ComingSuccessAdding extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
TextEditingController con=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: appBar(),
      ),
      body: body(),
      endDrawer: DrawerApp(),
      endDrawerEnableOpenDragGesture: false,
      bottomNavigationBar: GeneralBottomBar(MohafethSearching()),

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

  /*************bottomBar**********/
  Widget body(){
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('coming').snapshots();

    return Consumer<ProviderMasjed>(
      builder:(context,ProviderMasjed,x)=> Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              NameInAddingData(Text(""), true, false, "اسم المحفظ",ProviderMasjed.selectedMohafeth.mohafethName,con,(v){}),
              SizedBox(height: 20,),
              HistoryShape("م.", "التاريخ", "الحالة", Colors.white,mainColor,(){},(){}),
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
                      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                      if(data['name']==ProviderMasjed.selectedMohafeth.mohafethName){
                        int num=++count;
                        return  HistoryShape(num.toString(),data['date'], data['status'], Colors.black,Colors.white,(){},(){});

                      }else{
                        return SizedBox.shrink();
                      }
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
