import 'package:flutter/material.dart';
import 'package:masjed/MohafethUi/Mohafeth/mohafeth.dart';
import 'package:masjed/MoshrefUi/drawer/mohafethDrawer.dart';
import 'package:masjed/appBar.dart';
import 'package:masjed/MoshrefUi/drawer/drawer.dart';
import 'package:masjed/generalBottomBar.dart';
import 'package:masjed/main.dart';

import 'package:masjed/MoshrefUi/myData/dataPlace.dart';
import 'package:masjed/model/MohafethModel.dart';
import 'package:masjed/nameData.dart';
import 'package:masjed/provider.dart';
import 'package:provider/provider.dart';

import '../../bottomBar.dart';
class MohafethData extends StatefulWidget {
  @override
  _MohafethDataState createState() => _MohafethDataState();
}

class _MohafethDataState extends State<MohafethData> {
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
      endDrawer: MohafethDrawer(),
      endDrawerEnableOpenDragGesture: false,
      bottomNavigationBar: GeneralBottomBar(Mohafeth()),
    );
  }

  /*************appBar**********/
  Widget appBar() {
    return AppBarCustom(
      "بياناتي",
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
      builder:(context,ProviderMasjed,x)=> SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:20.0,left: 10,right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              NameInAddingData(Icon(Icons.account_circle_outlined,size: 100,color: Colors.black,), read, enable, "اسم المحفظ", (ProviderMasjed.loginUser as Mohafeth_model).mohafethName,con1,(v){}),
              SizedBox(height: 20,),
              DataPlace("رقم الهوية", con1, (ProviderMasjed.loginUser as Mohafeth_model).mohafethIdCard, read, enable),
              DataPlace("تاريخ الميلاد", con1,(ProviderMasjed.loginUser as Mohafeth_model).birthDate, read, enable),
              DataPlace("التخصص الاكاديمي", con1,(ProviderMasjed.loginUser as Mohafeth_model).feild, read, enable),
              DataPlace("رقم الجوال", con1,(ProviderMasjed.loginUser as Mohafeth_model).mobile, read, enable),
              DataPlace("رتبة العمل", con1, "محفظ", read, enable),
              DataPlace("حالة الاسرة", con1, (ProviderMasjed.loginUser as Mohafeth_model).familyStatus, read, enable),
            ],
          ),
        ),
      ),
    );
  }


}
