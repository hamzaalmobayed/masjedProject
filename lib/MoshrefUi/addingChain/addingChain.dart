import 'package:flutter/material.dart';
import 'package:masjed/MoshrefUi/chainSuccessAdding/chainSuccessAdding.dart';
import 'package:masjed/MoshrefUi/dataProcessScreen/screen.dart';
import 'package:masjed/MoshrefUi/drawer/drawer.dart';
import 'package:masjed/MoshrefUi/mohafethAdding/dropDownButtonAdding.dart';
import 'package:masjed/MoshrefUi/mohafethAdding/textFieldAdding.dart';
import 'package:masjed/MoshrefUi/moshref/Moshref.dart';
import 'package:masjed/appBar.dart';
import 'package:masjed/generalBottomBar.dart';
import 'package:masjed/main.dart';
import 'package:masjed/model/ChainModel.dart';
import 'package:masjed/model/MohafethModel.dart';
import 'package:masjed/nameData.dart';
import 'package:masjed/provider.dart';
import 'package:masjed/provider.dart';
import 'package:masjed/provider.dart';
import 'package:masjed/searchingResult/chainResult.dart';
import 'package:provider/provider.dart';

import '../../bottomBar.dart';
import '../../lists.dart';
class ChainAdding extends StatefulWidget {
  @override
  _ChainAddingState createState() => _ChainAddingState();
}

class _ChainAddingState extends State<ChainAdding> {
  TextEditingController con=TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool enable=true;

  bool read=false;
  TextEditingController con1=TextEditingController();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 0),(){
      Provider.of<ProviderMasjed>(context,listen: false).getAge();
      Provider.of<ProviderMasjed>(context,listen: false).getMohafethFromFirestore();
      Provider.of<ProviderMasjed>(context,listen: false).getHelperMohafethFromFirestore();
    });
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
      bottomNavigationBar: GeneralBottomBar(Screen(chains, "بيانات الحلقات")),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: floatingButton(),
    );
  }

  /*************appBar**********/
  Widget appBar() {
    return AppBarCustom(
      "اضافة حلقة",
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
              Chain_model chain=Chain_model(
                    chainName:ProviderMasjed.chainNameCon.text,
                    chainMohafeth:ProviderMasjed.selectedMohafeth.mohafethName,
                    chainhelper:ProviderMasjed.selectedHelperMohafeth.mohafethName,
                    age:ProviderMasjed.selectedAge,
                    number:ProviderMasjed.chainNumberCon.text
              );
              ProviderMasjed.add("chains", chain.toMap());
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (con) => ChainResult(ChainAdding(),DrawerApp())));
            },
            child: Icon(Icons.add,color: Colors.white,size: 30,),
          ),
        ),
      ),
    );
  }
  /*************body**********/
  Widget body(){
    return Consumer<ProviderMasjed>(
      builder:(context,ProviderMasjed,x){
        return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:20.0,left: 10,right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              NameInAddingData(ImageIcon(AssetImage("images/group.png"), color: Colors.black, size: 100), read, enable, "اسم الحلقة", "",ProviderMasjed.chainNameCon,(v){}),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: DropdownButton<Mohafeth_model>(
                          value:ProviderMasjed.selectedMohafeth,
                          icon: Icon(Icons.keyboard_arrow_down_sharp),

                          iconSize: 30,
                          elevation: 16,
                          isExpanded: true,
                          style: TextStyle(color: Colors.grey, fontSize: 17.0,fontFamily:"Cairo",),
                          underline: Container(
                            height: 2,
                            color: mainColor,
                          ),
                          onChanged: (newValue) {
                            ProviderMasjed.selectMohafeth(newValue);

                          },
                          items:
                          ProviderMasjed.mohafeths.map((value) {
                            return DropdownMenuItem<Mohafeth_model>(
                              value: value,
                              child: Text(value.mohafethName),
                            );
                          }).toList(),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: DropdownButton<Mohafeth_model>(
                        value:ProviderMasjed.selectedHelperMohafeth,
                        icon: Icon(Icons.keyboard_arrow_down_sharp),

                        iconSize: 30,
                        elevation: 16,
                        isExpanded: true,
                        style: TextStyle(color: Colors.grey, fontSize: 17.0,fontFamily:"Cairo",),
                        underline: Container(
                          height: 2,
                          color: mainColor,
                        ),
                        onChanged: (newValue) {
                          ProviderMasjed.selectHelperMohafeth(newValue);

                        },
                        items:
                        ProviderMasjed.helperMohafeths.map((value) {
                          return DropdownMenuItem<Mohafeth_model>(
                            value: value,
                            child: Text(value.mohafethName),
                          );
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: DropdownButton<String>(
                        value:ProviderMasjed.selectedAge,
                        icon: Icon(Icons.keyboard_arrow_down_sharp),

                        iconSize: 30,
                        elevation: 16,
                        isExpanded: true,
                        style: TextStyle(color: Colors.grey, fontSize: 17.0,fontFamily:"Cairo",),
                        underline: Container(
                          height: 2,
                          color: mainColor,
                        ),
                        onChanged: (newValue) {
                          ProviderMasjed.selectAge(newValue);

                        },
                        items:
                        ProviderMasjed.age.map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),

                    TextFieldAdding("رقم الحلقة", ProviderMasjed.chainNumberCon),
                  ],
                ),
              ),
            ],
          ),
        ),
      );}
    );
  }

}
