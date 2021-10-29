import 'package:flutter/material.dart';
import 'package:masjed/MoshrefUi/drawer/studentDrawer.dart';
import 'package:masjed/appBar.dart';
import 'package:masjed/MoshrefUi/drawer/drawer.dart';
import 'package:masjed/generalBottomBar.dart';
import 'package:masjed/main.dart';
import 'package:masjed/MoshrefUi/myData/dataPlace.dart';
import 'package:masjed/model/StudentModel.dart';
import 'package:masjed/nameData.dart';
import 'package:masjed/provider.dart';
import 'package:provider/provider.dart';
import '../../bottomBar.dart';
class StudentDataShowScreen extends StatefulWidget {
  Widget widget;

  StudentDataShowScreen(this.widget);

  @override
  _StudentDataShowScreenState createState() => _StudentDataShowScreenState();
}

class _StudentDataShowScreenState extends State<StudentDataShowScreen> {
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
      endDrawer: StudentDrawer(),
      endDrawerEnableOpenDragGesture: false,
      bottomNavigationBar: GeneralBottomBar(widget.widget),

    );
  }

  /*************appBar**********/
  Widget appBar() {
    return AppBarCustom(
      "بيانات الطالب",
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
              NameInAddingData(Icon(Icons.account_circle_outlined,size: 100,color: Colors.black,), read, enable, "اسم الطالب",(ProviderMasjed.loginUser as Student_model).studentName ,con1,(v){}),
              SizedBox(height: 20,),
              DataPlace("رقم الهوية", con1, (ProviderMasjed.loginUser as Student_model).studentCard, read, enable),
              DataPlace("تاريخ الميلاد", con1, (ProviderMasjed.loginUser as Student_model).birthDate, read, enable),
              DataPlace("الصف المدرسي", con1, (ProviderMasjed.loginUser as Student_model).classRoom, read, enable),
              DataPlace("رقم الجوال", con1, (ProviderMasjed.loginUser as Student_model).mobile, read, enable),
              DataPlace("اسم الحلقة", con1, (ProviderMasjed.loginUser as Student_model).chainName, read, enable),
              DataPlace("اخر دورة احكام", con1, (ProviderMasjed.loginUser as Student_model).course, read, enable),
              DataPlace("عنوان السكن", con1, (ProviderMasjed.loginUser as Student_model).address, read, enable),
              DataPlace("عمل الاب", con1, (ProviderMasjed.loginUser as Student_model).fatherWork, read, enable),
              DataPlace("رقم هوية الاب", con1, (ProviderMasjed.loginUser as Student_model).fatherIdCard, read, enable),
              DataPlace("كلمة المرور", con1, (ProviderMasjed.loginUser as Student_model).password, read, enable),

            ],
          ),
        ),
      ),
    );
  }


}
