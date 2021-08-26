import 'package:flutter/material.dart';
import 'package:masjed/MoshrefUi/dataProcessScreen/screen.dart';
import 'package:masjed/appBar.dart';
import 'package:masjed/MoshrefUi/drawer/drawer.dart';
import 'package:masjed/generalBottomBar.dart';
import 'package:masjed/main.dart';
import 'package:masjed/MoshrefUi/mohafethAdding/dropDownButtonAdding.dart';
import 'package:masjed/MoshrefUi/mohafethAdding/textFieldAdding.dart';
import 'package:masjed/MoshrefUi/moshref/Moshref.dart';
import 'package:masjed/model/ChainModel.dart';
import 'package:masjed/model/StudentModel.dart';
import 'package:masjed/nameData.dart';
import 'package:masjed/MoshrefUi/studentSuccessAdding/StudentSuccessAdding.dart';
import 'package:masjed/provider.dart';
import 'package:masjed/searchingResult/StudentResult.dart';
import 'package:provider/provider.dart';

import '../../bottomBar.dart';
import '../../lists.dart';
class StudentAdding extends StatefulWidget {
  @override
  _StudentAddingState createState() => _StudentAddingState();
}

class _StudentAddingState extends State<StudentAdding> {
  TextEditingController con=TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool enable=true;

  bool read=false;
  TextEditingController con1=TextEditingController();
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2),(){
      Provider.of<ProviderMasjed>(context,listen: false).getStatus();
      Provider.of<ProviderMasjed>(context,listen: false).getCourse();
      Provider.of<ProviderMasjed>(context,listen: false).getChainFromFirestore();
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
      bottomNavigationBar: GeneralBottomBar(Screen(students, "بيانات الطلاب")),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: floatingButton(),
    );
  }

  /*************appBar**********/
  Widget appBar() {
    return AppBarCustom(
      "اضافة طالب",
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
      builder:(conttext,ProviderMasjed,x)=> Padding(
        padding: const EdgeInsets.only(top: 80.0),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 35,
          child: FloatingActionButton(
            backgroundColor: mainColor,
            onPressed: (){
              ProviderMasjed.registerStudent();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (con) => StudentResult(StudentAdding(),DrawerApp())));
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
              NameInAddingData(Icon(Icons.account_circle_outlined,size: 100,color: Colors.black,), read, enable, "اسم الطالب", "",ProviderMasjed.studentNameCon),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    TextFieldAdding("رقم الهوية", ProviderMasjed.CardCon),
                    TextFieldAdding("تاريخ الميلاد", ProviderMasjed.studentBirthdayCon),
                    TextFieldAdding("رقم هوية الاب", ProviderMasjed.studentFatherCardCon),
                    TextFieldAdding("رقم الجوال", ProviderMasjed.studentMobileCon),
                    TextFieldAdding("الصف المدرسي", ProviderMasjed.studentClassCon),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: DropdownButton<Chain_model>(
                        value:ProviderMasjed.selectedChain,
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
                          ProviderMasjed.selectChain(newValue);

                        },
                        items:
                        ProviderMasjed.chains.map((value) {
                          return DropdownMenuItem<Chain_model>(
                            value: value,
                            child: Text(value.chainName),
                          );
                        }).toList(),
                      ),
                    ),
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
                    TextFieldAdding("كلمة المرور", ProviderMasjed.PasswordCon),
                    TextFieldAdding("عمل الاب", ProviderMasjed.studentFatherWorkCon),
                    TextFieldAdding("عنوان السكن", ProviderMasjed.studentAddressCon),
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
