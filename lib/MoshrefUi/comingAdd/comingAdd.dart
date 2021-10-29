import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:masjed/MoshrefUi/dailyhefth/hefthShape.dart';
import 'package:masjed/MoshrefUi/dataProcessScreen/screen.dart';
import 'package:masjed/MoshrefUi/drawer/drawer.dart';
import 'package:masjed/MoshrefUi/moshref/Moshref.dart';
import 'package:masjed/firebase/storage.dart';
import 'package:masjed/generalBottomBar.dart';
import 'package:masjed/provider.dart';
import 'package:provider/provider.dart';
import '../../appBar.dart';
import '../../bottomBar.dart';
import '../../lists.dart';
import '../../main.dart';
class ComingAdd extends StatefulWidget {
  @override
  _ComingAddState createState() => _ComingAddState();
}

class _ComingAddState extends State<ComingAdd> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    Provider.of<ProviderMasjed>(context,listen: false).getComingFromFirestore();
    Future.delayed(Duration(seconds: 1)).then((value) {
      if(Provider.of<ProviderMasjed>(context,listen: false).comingList.length==0||Provider.of<ProviderMasjed>(context,listen: false).comingList.last.date!=DateFormat('dd/MM/yyyy').format(DateTime.now())){
        Provider.of<ProviderMasjed>(context,listen: false).mohafeths.forEach((element) {
          print(element.mohafethName+'///////////////');
          String name=element.mohafethName;
          String date=Provider.of<ProviderMasjed>(context,listen: false).getDate();
          FireStore_Helper.FireStoreHelper.add("coming", {
            "name":name,
            "status":"لم يسجل",
            "date":date,
            "id":"",
            "color":"Colors.white"
          });
          Provider.of<ProviderMasjed>(context,listen: false).getId2("coming",name,date);
        });
      }
    });

  }
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
      bottomNavigationBar: GeneralBottomBar(Screen(coming, "حضور المحفظين")),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: floatingButton(),
    );
  }

  /*************appBar**********/
  Widget appBar() {
    return AppBarCustom(
      "اضافة حضور المحفظين",
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
            });
          },
          child: Icon(Icons.add,color: Colors.white,size: 30,),
        ),
      ),
    );
  }

  /*************body**********/
  Widget body(){
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('coming').snapshots();
    return Consumer<ProviderMasjed>(
      builder:(context,ProviderMasjed,x)=> SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 40),
          child: Column(
            children: [
              HefthShape("ح.", "اسم المحفظ",  Colors.white,mainColor,(){},(){},(){}),
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
                      if(data['date']==DateFormat('dd/MM/yyyy').format(DateTime.now())){
                        return HefthShape("", data['name'], data['color']=="mainColor"?Colors.white:mainColor,data['color']=="mainColor"?mainColor:Colors.white,(){},(){
                          print("pressed");
                          if(data['color']=='Colors.white'){
                            FireStore_Helper.FireStoreHelper.fireStore.collection("coming").doc(data['id']).update(
                                {
                                  "name":data['name'],
                                  "status":"حاضر",
                                  "date":ProviderMasjed.getDate(),
                                  "id":data['id'],
                                  "color":"mainColor"
                                });
                          }else{
                            FireStore_Helper.FireStoreHelper.fireStore.collection("coming").doc(data['id']).update(
                                {
                                  "name":data['name'],
                                  "status":"غائب",
                                  "date":ProviderMasjed.getDate(),
                                  "id":data['id'],
                                  "color":"Colors.white"
                                });
                          }
                        },(){});
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
