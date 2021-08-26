import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:masjed/MoshrefUi/drawer/drawer.dart';
import 'package:masjed/MoshrefUi/moshref/Moshref.dart';
import 'package:masjed/MoshrefUi/myData/dataPlace.dart';
import 'package:masjed/appBar.dart';
import 'package:masjed/generalBottomBar.dart';
import 'package:masjed/main.dart';

import 'package:masjed/nameData.dart';
import 'package:masjed/provider.dart';
import 'package:provider/provider.dart';

import '../../bottomBar.dart';
class ChainSuccessAdding extends StatefulWidget {
  Widget widget;
  Widget drawer;

  ChainSuccessAdding(this.widget,this.drawer);

  @override
  _ChainSuccessAddingState createState() => _ChainSuccessAddingState();
}

class _ChainSuccessAddingState extends State<ChainSuccessAdding> {
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
      endDrawer:widget.drawer,
      endDrawerEnableOpenDragGesture: false,
      bottomNavigationBar: GeneralBottomBar(widget.widget),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: floatingButton(),
    );
  }

  /*************appBar**********/
  Widget appBar() {
    return AppBarCustom(
      "بيانات الحلقة",
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
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('chains').snapshots();
    return Consumer<ProviderMasjed>(
        builder:(context,ProviderMasjed,x)=> SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top:20.0,left: 10,right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                    String name=data["chainName"];
                    if(name.contains(ProviderMasjed.searchingCon.text)){
                      return Column(
                        children: [
                          NameInAddingData(ImageIcon(
                            AssetImage("images/group.png"),
                            color: Colors.black,
                            size: 70,
                          ), read, enable, "اسم الحلقة", data['chainName'],con1),
                          SizedBox(height: 20,),
                          DataPlace("محفظ الحلقة", con1, data['chainMohafeth'], read, enable),
                          DataPlace("المحفظ المساعد", con1, data['chainhelper'], read, enable),
                          DataPlace("الفئة العمرية", con1, data['age'], read, enable),
                          DataPlace("رقم الحلقة", con1, data['number'], read, enable),
                        ],
                      );

                    }else{
                      return Text("");
                    }

                  }).toList(),
                );



              },
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: ElevatedButton(
                onPressed: ()=>Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (con)=>Moshref())),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(mainColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        )
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text("عرض بيانات الطلاب",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold,),),
                ),
              ),
            ),

          ],
        ),
      ),
    )
    );
  }

}
