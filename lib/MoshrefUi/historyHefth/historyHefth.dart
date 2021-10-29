import 'package:flutter/material.dart';
import 'package:masjed/MoshrefUi/drawer/drawer.dart';
import 'package:masjed/MoshrefUi/myData/dataPlace.dart';
import 'package:masjed/MoshrefUi/reportAdding/beginEngHefth.dart';
import 'package:masjed/appBar.dart';
import 'package:masjed/generalBottomBar.dart';
import 'package:masjed/main.dart';
import 'package:masjed/model/HefthModel.dart';
import 'package:masjed/nameData.dart';
import 'package:provider/provider.dart';

import '../../bottomBar.dart';
import '../../provider.dart';
class HistoryHefth extends StatefulWidget {
  Widget widget;
  Widget drawer;
  HistoryHefth(this.widget,this.drawer);

  @override
  _HistoryHefthState createState() => _HistoryHefthState();
}

class _HistoryHefthState extends State<HistoryHefth> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool enable=true;
  TextEditingController con=TextEditingController();
  bool read=false;
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
      endDrawer: widget.drawer,
      endDrawerEnableOpenDragGesture: false,
      bottomNavigationBar: GeneralBottomBar(widget.widget),

    );
  }

  /*************appBar**********/
  Widget appBar() {
    return AppBarCustom(
      "تقرير حفظ الطالب",
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
      builder: (context,ProviderMasjed,x)=>SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:20.0,left: 10,right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              NameInAddingData(Icon(Icons.account_circle_outlined,size: 100,color: Colors.black,), read, enable, "اسم الطالب", ProviderMasjed.pressedHistory.studentNameHefth,con,(v){}),
              SizedBox(height: 20,),
              BeginEngHefth("بداية الحفظ", "اية", "سورة", con,con, ProviderMasjed.pressedHistory.beginAya, ProviderMasjed.pressedHistory.beginSora, read, enable),
              BeginEngHefth("نهاية الحفظ", "اية", "سورة",con,con,ProviderMasjed.pressedHistory.endAya, ProviderMasjed.pressedHistory.endSora, read, enable),
              DataPlace(" عدد صفحات الحفظ", con, ProviderMasjed.pressedHistory.pageNumber, read, enable),
              DataPlace("عدد صفحات المراجعة", con,ProviderMasjed.pressedHistory.revisionPage, read, enable),
              DataPlace("الدرجة", con, ProviderMasjed.pressedHistory.estimate, read, enable),

            ],
          ),
        ),
      ),
    );
  }


}
