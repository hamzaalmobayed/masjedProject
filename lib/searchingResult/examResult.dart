import 'package:flutter/material.dart';
import 'package:masjed/MoshrefUi/myData/dataPlace.dart';
import 'package:masjed/appBar.dart';
import 'package:masjed/generalBottomBar.dart';
import 'package:masjed/nameData.dart';
import 'package:provider/provider.dart';
import '../../../../bottomBar.dart';
import '../../provider.dart';

import '../../main.dart';

class ExamResult extends StatefulWidget {
  Widget widget;
  Widget drawer;
  ExamResult(this.widget,this.drawer);

  @override
  _ExamResultState createState() => _ExamResultState();
}

class _ExamResultState extends State<ExamResult> {
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
      endDrawer: widget.drawer,
      endDrawerEnableOpenDragGesture: false,
      bottomNavigationBar: GeneralBottomBar(widget.widget),

    );
  }

  /*************appBar**********/
  Widget appBar() {
    return AppBarCustom(
      "ارشيف الاختبارات",
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
      builder: (con,ProviderMasjed,x)=> SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:20.0,left: 10,right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              NameInAddingData(Icon(Icons.account_circle_outlined,size: 100,color: Colors.black,), read, enable, "اسم الطالب", ProviderMasjed.selectedChainStudent.studentName,con1),
              SizedBox(height: 20,),
              DataPlace("اسم الجزء", con1, ProviderMasjed.conExamName.text, read, enable),
              DataPlace("اسم الحلقة", con1,ProviderMasjed.selectedChain.chainName , read, enable),
              DataPlace("العلامة بالدرجات", con1, ProviderMasjed.conExamMark.text, read, enable),
              DataPlace("التقدير", con1, ProviderMasjed.conExamEstimation.text, read, enable),
              DataPlace("تاريخ الاختبار", con1, ProviderMasjed.conExamDate.text, read, enable),
              DataPlace("الشيخ المختبر", con1, ProviderMasjed.conExamPerson.text, read, enable),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: ElevatedButton(
                  onPressed: (){
                    ProviderMasjed.createPDF();
                  },
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
                    child: Text("اصدار شهادة",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold,),),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

}
