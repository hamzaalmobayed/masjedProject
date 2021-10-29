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
class StudentDataView extends StatefulWidget {
  Widget widget;
  Widget drawer;


  StudentDataView(this.widget,this.drawer);
  @override
  _StudentDataViewState createState() => _StudentDataViewState();
}

class _StudentDataViewState extends State<StudentDataView> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool enable=false;
  bool read=true;
  TextEditingController con1=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProviderMasjed>(context,listen: false).studentNameCon1.text=Provider.of<ProviderMasjed>(context,listen: false).pressedStudentShow.studentName;
    Provider.of<ProviderMasjed>(context,listen: false).studentCardCon1.text=Provider.of<ProviderMasjed>(context,listen: false).pressedStudentShow.studentCard;
    Provider.of<ProviderMasjed>(context,listen: false).studentBirthdayCon1.text=Provider.of<ProviderMasjed>(context,listen: false).pressedStudentShow.birthDate;
    Provider.of<ProviderMasjed>(context,listen: false).studentClassCon1.text=Provider.of<ProviderMasjed>(context,listen: false).pressedStudentShow.classRoom;
    Provider.of<ProviderMasjed>(context,listen: false).studentMobileCon1.text=Provider.of<ProviderMasjed>(context,listen: false).pressedStudentShow.mobile;
    Provider.of<ProviderMasjed>(context,listen: false).studentChainCon11.text=Provider.of<ProviderMasjed>(context,listen: false).pressedStudentShow.chainName;
    Provider.of<ProviderMasjed>(context,listen: false).studentStatusCon11.text=Provider.of<ProviderMasjed>(context,listen: false).pressedStudentShow.familyStatus;
    Provider.of<ProviderMasjed>(context,listen: false).studentCourseCon11.text=Provider.of<ProviderMasjed>(context,listen: false).pressedStudentShow.course;
    Provider.of<ProviderMasjed>(context,listen: false).studentAddressCon1.text=Provider.of<ProviderMasjed>(context,listen: false).pressedStudentShow.address;
    Provider.of<ProviderMasjed>(context,listen: false).studentFatherWorkCon1.text=Provider.of<ProviderMasjed>(context,listen: false).pressedStudentShow.fatherWork;
    Provider.of<ProviderMasjed>(context,listen: false).studentFatherCardCon1.text=Provider.of<ProviderMasjed>(context,listen: false).pressedStudentShow.fatherIdCard;
    Provider.of<ProviderMasjed>(context,listen: false).studentPasswordCon1.text=Provider.of<ProviderMasjed>(context,listen: false).pressedStudentShow.password;
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
      endDrawer: widget.drawer,
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
              String studentUpdate;
              setState(() {
                enable=!enable;
                read=!read;
              });
              if(enable==true){
                studentUpdate=ProviderMasjed.mohafethNameCon2.text;
              }
              if(enable==false){
                Student_model student=Student_model(
                  studentName:ProviderMasjed.studentNameCon1.text,
                  studentCard: ProviderMasjed.studentCardCon1.text,
                  birthDate: ProviderMasjed.studentBirthdayCon1.text,
                  fatherIdCard:ProviderMasjed.studentFatherCardCon1.text,
                  fatherWork:ProviderMasjed.studentFatherWorkCon1.text,
                  mobile:ProviderMasjed.studentMobileCon1.text,
                  classRoom: ProviderMasjed.studentClassCon1.text,
                  chainName: ProviderMasjed.studentChainCon11.text,
                  familyStatus:ProviderMasjed.studentStatusCon11.text,
                  password:ProviderMasjed.studentPasswordCon1.text,
                  address:ProviderMasjed.studentAddressCon1.text,
                  course: ProviderMasjed.studentCourseCon11.text,
                );
                FirebaseFirestore.instance
                    .collection("reports")
                    .where("studentNameHefth", isEqualTo : ProviderMasjed.pressedStudentShow.studentName)
                    .get().then((value){
                  value.docs.forEach((element) {
                    FirebaseFirestore.instance.collection("reports").doc(element.id).update(
                        {"studentNameHefth":ProviderMasjed.studentNameCon1.text}).then((value){
                      print("Success!");
                    });
                  });
                });
                FirebaseFirestore.instance
                    .collection("messages")
                    .where("sender", isEqualTo : ProviderMasjed.pressedStudentShow.studentName)
                    .get().then((value){
                  value.docs.forEach((element) {
                    FirebaseFirestore.instance.collection("messages").doc(element.id).update(
                        {"sender":ProviderMasjed.mohafethNameCon2.text}).then((value){
                      print("Success!");
                    });
                  });
                });
                FirebaseFirestore.instance
                    .collection("messages")
                    .where("receiver", isEqualTo : ProviderMasjed.pressedStudentShow.studentName)
                    .get().then((value){
                  value.docs.forEach((element) {
                    FirebaseFirestore.instance.collection("messages").doc(element.id).update(
                        {"receiver":ProviderMasjed.mohafethNameCon2.text}).then((value){
                      print("Success!");
                    });
                  });
                });
                FirebaseFirestore.instance
                    .collection("students")
                    .where("studentCard", isEqualTo : ProviderMasjed.pressedStudentShow.studentCard)
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
              NameInAddingData(Icon(Icons.account_circle_outlined,size: 100,color: Colors.black,), read, enable, "اسم الطالب", ProviderMasjed.pressedStudentShow.studentName,ProviderMasjed.studentNameCon1,(v){}),
              SizedBox(height: 20,),
              DataPlace("رقم الهوية", ProviderMasjed.studentCardCon1, '', read, enable),
              DataPlace("تاريخ الميلاد", ProviderMasjed.studentBirthdayCon1,'', read, enable),
              DataPlace("الصف المدرسي", ProviderMasjed.studentClassCon1, '', read, enable),
              DataPlace("رقم الجوال", ProviderMasjed.studentMobileCon1, '', read, enable),
              DataPlace("اسم الحلقة", ProviderMasjed.studentChainCon11,'', read, enable),
              DataPlace("حالة الاسرة", ProviderMasjed.studentStatusCon11,'', read, enable),
              DataPlace("اخر دورة احكام", ProviderMasjed.studentCourseCon11,'', read, enable),
              DataPlace("عنوان السكن", ProviderMasjed.studentAddressCon1,'', read, enable),
              DataPlace("عمل الاب", ProviderMasjed.studentFatherWorkCon1,'', read, enable),
              DataPlace("رقم هوية الاب", ProviderMasjed.studentFatherCardCon1,'', read, enable),
              DataPlace("كلمة المرور", ProviderMasjed.studentPasswordCon1,'', read, enable)


            ],
          ),
        ),
      ),
    );
  }

}
