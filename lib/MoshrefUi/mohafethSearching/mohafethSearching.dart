import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masjed/MoshrefUi/comingSuccessAdding/comingSuccessAdding.dart';
import 'package:masjed/MoshrefUi/dataProcessScreen/screen.dart';
import 'package:masjed/MoshrefUi/drawer/drawer.dart';
import 'package:masjed/MoshrefUi/moshref/Moshref.dart';
import 'package:masjed/MoshrefUi/report/reportFieldShape.dart';
import 'package:masjed/generalBottomBar.dart';
import 'package:masjed/model/MohafethModel.dart';
import 'package:masjed/provider.dart';
import 'package:provider/provider.dart';

import '../../appBar.dart';
import '../../bottomBar.dart';
import '../../lists.dart';
import '../../main.dart';
class MohafethSearching extends StatelessWidget {
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
      endDrawer: DrawerApp(),
      endDrawerEnableOpenDragGesture: false,
      body: body(),
      bottomNavigationBar: GeneralBottomBar(Screen(coming, "حضور المحفظين")),
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
    return Consumer<ProviderMasjed>(
      builder:(context,ProviderMasjed,x)=> Center(
        child: SingleChildScrollView(

          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 314,
                  height: 200,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 10.0,
                        ),
                      ],
                      color:mainColor,
                      borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("اختر محفظا",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
                          SizedBox(height: 5,),
                          Container(
                            width: 270,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.fromBorderSide(BorderSide(width: 1,)),
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 10.0,
                                ),
                              ],),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: DropdownButton<Mohafeth_model>(

                                isExpanded: true,
                                underline: SizedBox(),
                                icon: Icon(Icons.keyboard_arrow_down_sharp,color: Colors.black,),
                                iconSize: 30,
                                items: ProviderMasjed.mohafeths.map((Mohafeth_model value) {
                                  return DropdownMenuItem<Mohafeth_model>(
                                    value: value,
                                    child: new Text(value.mohafethName),
                                  );
                                }).toList(),
                                onChanged: (v) {
                                  ProviderMasjed.selectMohafeth(v);
                                },
                                value: ProviderMasjed.selectedMohafeth,
                              ),
                            ),
                          )
                        ],
                      )

                    ],
                  ) ,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 80),
                  child: ElevatedButton(
                    onPressed: () =>Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (con)=>ComingSuccessAdding())),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              side: BorderSide(width: 2,color: mainColor),
                              borderRadius: BorderRadius.circular(50.0),
                            )
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("تم",style: TextStyle(fontSize: 20,color: mainColor,fontWeight: FontWeight.bold,),),
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
