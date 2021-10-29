import 'package:flutter/material.dart';
import 'package:masjed/MoshrefUi/dataProcessScreen/screen.dart';
import 'package:masjed/MoshrefUi/hafethResult/hafethResult.dart';
import 'package:masjed/MoshrefUi/history/History.dart';
import 'package:masjed/appBar.dart';
import 'package:masjed/MoshrefUi/drawer/drawer.dart';
import 'package:masjed/firebase/storage.dart';
import 'package:masjed/generalBottomBar.dart';
import 'package:masjed/main.dart';
import 'package:masjed/MoshrefUi/mohafethAdding/dropDownButtonAdding.dart';
import 'package:masjed/MoshrefUi/mohafethAdding/textFieldAdding.dart';
import 'package:masjed/MoshrefUi/mohafethSuccessAdding/mohafethSuccessAdding.dart';
import 'package:masjed/MoshrefUi/moshref/Moshref.dart';
import 'package:masjed/model/HafethModel.dart';
import 'package:masjed/model/MohafethModel.dart';
import 'package:masjed/nameData.dart';
import 'package:masjed/searchingResult/mohafethResult.dart';
import 'package:provider/provider.dart';

import '../../bottomBar.dart';
import '../../lists.dart';
import '../../provider.dart';
class HafethAdding extends StatefulWidget {
  @override
  _HafethAddingState createState() => _HafethAddingState();
}

class _HafethAddingState extends State<HafethAdding> {
  TextEditingController con=TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool enable=true;

  bool read=false;
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2),(){
      Provider.of<ProviderMasjed>(context,listen: false).getHefthStatus();
      Provider.of<ProviderMasjed>(context,listen: false).getStatus();
      Provider.of<ProviderMasjed>(context,listen: false).getCourse();
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
      bottomNavigationBar: GeneralBottomBar(History()),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: floatingButton(),
    );
  }

  /*************appBar**********/
  Widget appBar() {
    return AppBarCustom(
      "اضافة محفظ",
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
      builder:(context,ProviderMasjed,x) =>Padding(
        padding: const EdgeInsets.only(top: 80.0),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 35,
          child: FloatingActionButton(
            backgroundColor: mainColor,
            onPressed: (){
              Hafeth_model hafeth=Hafeth_model(
                  hafethName:ProviderMasjed.hafethNameCon1.text,
                  hafethIdCard:ProviderMasjed.hafethCardCon1.text,
                  birthDate:ProviderMasjed.hafethBirthdayCon1.text,
                  feild:ProviderMasjed.hafethFeildCon1.text,
                  mobile:ProviderMasjed.hafethMobileCon1.text,
                  familyStatus:ProviderMasjed.selectedStatus,
                  mohafethName:ProviderMasjed.hafethMohafethCon1.text,
                  course:ProviderMasjed.selectedCourse,
                  hefthDate:ProviderMasjed.hafethDateCon1.text ,
                  hefthStatus:ProviderMasjed.selectedHefthStatus
              );
              ProviderMasjed.add('hafeth', hafeth.toMap());

              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (con)=>HafethResult(HafethAdding(),DrawerApp())));
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
      builder:(context,ProviderMasjed,x)=> SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:20.0,left: 10,right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              NameInAddingData(Icon(Icons.account_circle_outlined,size: 100,color: Colors.black,), read, enable, "اسم المحفظ", "",ProviderMasjed.hafethNameCon1,(v){}),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  children: [
                    TextFieldAdding("رقم الهوية", ProviderMasjed.hafethCardCon1),
                    TextFieldAdding("تاريخ الميلاد", ProviderMasjed.hafethBirthdayCon1),
                    TextFieldAdding("التخصص الاكاديمي", ProviderMasjed.hafethFeildCon1),
                    TextFieldAdding("رقم الجوال", ProviderMasjed.hafethMobileCon1),
                    TextFieldAdding("الشيخ المحفظ", ProviderMasjed.hafethMohafethCon1),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: DropdownButton<String>(
                        value:ProviderMasjed.selectedStatus,
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
                          ProviderMasjed.selectStatus(newValue);

                        },
                        items:
                        ProviderMasjed.StatusList.map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    TextFieldAdding("تاريخ الحفظ", ProviderMasjed.hafethDateCon1),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: DropdownButton<String>(
                        value:ProviderMasjed.selectedCourse,
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
                          ProviderMasjed.selectCourse(newValue);

                        },
                        items:
                        ProviderMasjed.CourseList.map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: DropdownButton<String>(
                        value:ProviderMasjed.selectedHefthStatus,
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
                          ProviderMasjed.selectHefthStatus(newValue);

                        },
                        items:
                        ProviderMasjed.hefthStatus.map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
