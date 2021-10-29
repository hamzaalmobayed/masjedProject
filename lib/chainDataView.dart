import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:masjed/MoshrefUi/drawer/drawer.dart';
import 'package:masjed/MoshrefUi/moshref/Moshref.dart';
import 'package:masjed/MoshrefUi/myData/dataPlace.dart';
import 'package:masjed/appBar.dart';
import 'package:masjed/generalBottomBar.dart';
import 'package:masjed/main.dart';
import 'package:masjed/model/ChainModel.dart';

import 'package:masjed/nameData.dart';
import 'package:masjed/provider.dart';
import 'package:provider/provider.dart';

import '../../bottomBar.dart';
import 'MohafethUi/studentChainShow/studentChainShow.dart';
import 'MoshrefUi/chainDataShow/chainDataShow.dart';
class ChainDataView extends StatefulWidget {
  Widget widget;
  Widget drawer;

  ChainDataView(this.widget,this.drawer);

  @override
  _ChainDataViewState createState() => _ChainDataViewState();
}

class _ChainDataViewState extends State<ChainDataView> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool enable=false;

  bool read=true;
  TextEditingController con1=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProviderMasjed>(context,listen: false).chainNameCon1.text=Provider.of<ProviderMasjed>(context,listen: false).pressedChainShow.chainName;
    Provider.of<ProviderMasjed>(context,listen: false).chainMohafethCon11.text=Provider.of<ProviderMasjed>(context,listen: false).pressedChainShow.chainMohafeth;
    Provider.of<ProviderMasjed>(context,listen: false).chainHelperCon11.text=Provider.of<ProviderMasjed>(context,listen: false).pressedChainShow.chainhelper;
    Provider.of<ProviderMasjed>(context,listen: false).chainAgeCon11.text=Provider.of<ProviderMasjed>(context,listen: false).pressedChainShow.age;
    Provider.of<ProviderMasjed>(context,listen: false).chainNumberCon1.text=Provider.of<ProviderMasjed>(context,listen: false).studentNumber.toString();
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
      endDrawer:widget.drawer,
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
    return Consumer<ProviderMasjed>(
      builder:(context,ProviderMasjed,x)=> Padding(
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
              if(enable==false){
                Chain_model chain=Chain_model(
                    chainName:ProviderMasjed.chainNameCon1.text,
                    chainMohafeth:ProviderMasjed.chainMohafethCon11.text,
                    chainhelper:ProviderMasjed.chainHelperCon11.text,
                    age:ProviderMasjed.chainAgeCon11.text,
                    number:ProviderMasjed.chainNumberCon1.text,
                );
                FirebaseFirestore.instance
                    .collection("chains")
                    .where("chainMohafeth", isEqualTo : ProviderMasjed.selectedMohafeth.mohafethName)
                    .get().then((value){
                  value.docs.forEach((element) {
                    FirebaseFirestore.instance.collection("chains").doc(element.id).update(chain.toMap()).then((value){
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
                NameInAddingData(ImageIcon(
                  AssetImage("images/group.png"),
                  color: Colors.black,
                  size: 70,
                ), read, enable, "اسم الحلقة", ProviderMasjed.pressedChainShow.chainName,ProviderMasjed.chainNameCon1,(v){}),
                SizedBox(height: 20,),
                DataPlace("محفظ الحلقة", ProviderMasjed.chainMohafethCon11,'', read, enable),
                DataPlace("المحفظ المساعد", ProviderMasjed.chainHelperCon11,'', read, enable),
                DataPlace("الفئة العمرية", ProviderMasjed.chainAgeCon11,'', read, enable),
                DataPlace("عدد الطلاب", ProviderMasjed.chainNumberCon1,'', read, enable),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: ElevatedButton(
                    onPressed: ()=>Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (con)=>StudentChainShow(ChainDataView(ChainDataShow(), Drawer()),Drawer()))),
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
