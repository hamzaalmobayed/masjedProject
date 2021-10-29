import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
class StudentResult extends StatefulWidget {
  Widget widget;
  Widget drawer;


  StudentResult(this.widget,this.drawer);

  @override
  _StudentResultState createState() => _StudentResultState();
}

class _StudentResultState extends State<StudentResult> {
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
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: floatingButton(),
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
                Student_model student=Student_model(
                  studentName:ProviderMasjed.studentNameCon.text,
                  studentCard: ProviderMasjed.CardCon.text,
                  birthDate: ProviderMasjed.studentBirthdayCon.text,
                  fatherIdCard:ProviderMasjed.studentFatherCardCon.text,
                  fatherWork:ProviderMasjed.studentFatherWorkCon.text,
                  mobile:ProviderMasjed.studentMobileCon.text,
                  classRoom: ProviderMasjed.studentClassCon.text,
                  chainName: ProviderMasjed.studentChainCon1.text==null?ProviderMasjed.selectedChain.chainName:ProviderMasjed.studentChainCon1.text,
                  familyStatus:ProviderMasjed.studentStatusCon1.text==null?ProviderMasjed.selectedStatus:ProviderMasjed.studentStatusCon1.text,
                  password:ProviderMasjed.PasswordCon.text,
                  address:ProviderMasjed.studentAddressCon.text,
                  course: ProviderMasjed.studentCourseCon1.text==null?ProviderMasjed.selectedCourse:ProviderMasjed.studentCourseCon1.text,
                );
                FirebaseFirestore.instance
                    .collection("students")
                    .where("studentCard", isEqualTo : ProviderMasjed.CardCon.text)
                    .get().then((value){
                  value.docs.forEach((element) {
                    FirebaseFirestore.instance.collection("students").doc(element.id).update(student.toMap()).then((value){
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
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('students').snapshots();
    return Consumer<ProviderMasjed>(
      builder:(context,ProviderMasjed,x)=> SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:20.0,left: 10,right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              NameInAddingData(Icon(Icons.account_circle_outlined,size: 100,color: Colors.black,), read, enable, "اسم الطالب", ProviderMasjed.studentNameCon.text,ProviderMasjed.studentNameCon,(v){}),
              SizedBox(height: 20,),
              DataPlace("رقم الهوية", ProviderMasjed.CardCon, ProviderMasjed.CardCon.text, read, enable),
              DataPlace("تاريخ الميلاد", ProviderMasjed.studentBirthdayCon, ProviderMasjed.studentBirthdayCon.text, read, enable),
              DataPlace("الصف المدرسي", ProviderMasjed.studentClassCon, ProviderMasjed.studentClassCon.text, read, enable),
              DataPlace("رقم الجوال", ProviderMasjed.studentMobileCon, ProviderMasjed.studentMobileCon.text, read, enable),
              DataPlace("اسم الحلقة", ProviderMasjed.studentChainCon1, ProviderMasjed.selectedChain.chainName, read, enable),
              DataPlace("حالة الاسرة",ProviderMasjed.studentStatusCon1 , ProviderMasjed.selectedStatus, read, enable),
              DataPlace("اخر دورة احكام", ProviderMasjed.studentCourseCon1, ProviderMasjed.selectedCourse, read, enable),
              DataPlace("عنوان السكن", ProviderMasjed.studentAddressCon, ProviderMasjed.studentAddressCon.text, read, enable),
              DataPlace("عمل الاب", ProviderMasjed.studentFatherWorkCon, ProviderMasjed.studentFatherWorkCon.text, read, enable),
              DataPlace("رقم هوية الاب", ProviderMasjed.studentFatherCardCon,ProviderMasjed.studentFatherCardCon.text, read, enable),
              DataPlace("كلمة المرور", ProviderMasjed.PasswordCon,  ProviderMasjed.PasswordCon.text, read, enable),


            ],
          ),
        ),
      ),
    );
  }

}
