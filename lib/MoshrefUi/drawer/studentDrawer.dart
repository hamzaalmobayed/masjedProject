

import 'package:flutter/material.dart';
import 'package:masjed/MohafethUi/Mohafeth/mohafeth.dart';
import 'package:masjed/MohafethUi/dataExport/dataExport.dart';
import 'package:masjed/MohafethUi/mohafethData/mohafethData.dart';
import 'package:masjed/MohafethUi/studentDataProccess/studentData.dart';
import 'package:masjed/MohafethUi/studentExam/studentExam.dart';
import 'package:masjed/MoshrefUi/dailyhefth/hefth.dart';
import 'package:masjed/MoshrefUi/examSearchData/examSearchingData.dart';
import 'package:masjed/MoshrefUi/login/loginScreen.dart';
import 'package:masjed/MoshrefUi/messaging/message.dart';
import 'package:masjed/MoshrefUi/mohafethSuccessAdding/mohafethSuccessAdding.dart';
import 'package:masjed/MoshrefUi/myData/myData.dart';
import 'package:masjed/MoshrefUi/studentDataShow/studentDataShow.dart';
import 'package:masjed/MoshrefUi/studentSuccessAdding/StudentSuccessAdding.dart';
import 'package:masjed/StudentUi/student/student.dart';
import 'package:masjed/StudentUi/studentChain/studentChain.dart';
import 'package:masjed/StudentUi/studentDailyhefthScreen/studentDailyHefthScreen.dart';
import 'package:masjed/StudentUi/studentData/studentData.dart';
import 'package:masjed/StudentUi/studentExamData/studentExamData.dart';
import 'package:masjed/StudentUi/studentScreenReport/srudentScreenReport.dart';
import 'package:masjed/appBar.dart';
import 'package:masjed/provider.dart';
import 'package:masjed/sharedPreferences.dart';
import 'package:provider/provider.dart';

import 'drawerButton.dart';

class StudentDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          AppBarCustom(
              "",
              Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 30,
              ), () {
            Navigator.of(context).pop();
          }),
          DrawerButton(
              ImageIcon(
                AssetImage("images/sheet.png"),
                color: Colors.black,
                size: 30,
              ),
              "??????????????",
                  () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (con)=>StudentDataShowScreen(Student())));
              }),
          DrawerButton(
              ImageIcon(
                AssetImage("images/cup.png"),
                color: Colors.black,
                size: 30,
              ),
              "?????????? ????????????????",
                  () {
                    Provider.of<ProviderMasjed>(context,listen: false).getStudentbeginReportFromFirestore();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (con)=>StudentScreenReport(Student(),StudentDrawer())));
              }),
          DrawerButton(
              Icon(Icons.card_giftcard,
                color: Colors.black,
                size: 30,),
              "?????????? ??????????????????",
                  () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (con)=>StudentExamData(Student(),StudentDrawer())));
              }),
          DrawerButton(
              Icon(Icons.image_search,
                color: Colors.black,
                size: 30,),
              "?????????? ??????????",
                  () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (con)=>StudentDailyHefthScreen(Student(),StudentDrawer())));
              }),
          DrawerButton(
              Icon(
                Icons.people_alt_outlined,
                color: Colors.black,
                size: 30,
              ),
              "?????????? ?? ????????????????", () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (con)=>StudentChain(Student(),StudentDrawer())));
          }),
          Consumer<ProviderMasjed>(
              builder:(context,ProviderMasjed,x)=>  DrawerButton(
              Icon(
                Icons.logout_outlined,
                color: Colors.black,
                size: 30,
              ),
              "?????????? ????????", () {
            ProviderMasjed.loginUser=null;
            Helper.x.Signout("login");
            ProviderMasjed.conLoginCard.clear();
            ProviderMasjed.conLoginPassword.clear();
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (con)=>Login()));
          })),
        ],
      ),
    );
  }
}
