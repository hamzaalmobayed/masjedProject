import 'package:flutter/material.dart';
import 'package:masjed/MohafethUi/Mohafeth/mohafethStudentComing.dart';
import 'package:masjed/MohafethUi/studentExam/studentExam.dart';
import 'package:masjed/MoshrefUi/drawer/drawerButton.dart';
import 'package:masjed/MoshrefUi/drawer/fatherDrawer.dart';
import 'package:masjed/MoshrefUi/drawer/mohafethDrawer.dart';
import 'package:masjed/MoshrefUi/drawer/studentDrawer.dart';
import 'package:masjed/MoshrefUi/examDataShow/examDataShow.dart';
import 'package:masjed/MoshrefUi/examSearchData/examResult.dart';
import 'package:masjed/MoshrefUi/examSearchData/examSearchingData.dart';
import 'package:masjed/MoshrefUi/moshref/Moshref.dart';
import 'package:masjed/MoshrefUi/moshref/name.dart';
import 'package:masjed/MoshrefUi/studentSuccessAdding/StudentSuccessAdding.dart';
import 'package:masjed/StudentUi/student/studentButtonScreen.dart';
import 'package:masjed/StudentUi/studentChain/studentChain.dart';
import 'package:masjed/StudentUi/studentDailyhefthScreen/studentDailyHefthScreen.dart';
import 'package:masjed/StudentUi/studentData/studentData.dart';
import 'package:masjed/StudentUi/studentExamData/studentExamData.dart';
import 'package:masjed/StudentUi/studentScreenReport/srudentScreenReport.dart';
import 'package:masjed/bottomBar.dart';
import 'package:masjed/fatherUI/appBarFather.dart';
import 'package:masjed/main.dart';
import 'package:masjed/model/StudentModel.dart';
import 'package:masjed/triangle.dart';
import 'package:provider/provider.dart';

import '../../mainAppBar.dart';
import '../../provider.dart';
class Father extends StatefulWidget {

  @override
  _FatherState createState() => _FatherState();
}

class _FatherState extends State<Father> {
  void initState() {
    super.initState();
    Provider.of<ProviderMasjed>(context,listen: false).getStudentExamsFromFirestore();
    Provider.of<ProviderMasjed>(context,listen: false).getSpecifyReportsFromFirestore();
    Provider.of<ProviderMasjed>(context,listen: false).getSpecifyChainStudentFromFirestore();
    Provider.of<ProviderMasjed>(context,listen: false).getStudentbeginReportFromFirestore();
    Provider.of<ProviderMasjed>(context,listen: false).getDailyHefthFromFirestore();
    Provider.of<ProviderMasjed>(context,listen: false).getAllChats();


  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderMasjed>(
        builder: (context,ProviderMasjed,x)=>Stack(
            children: [
              Scaffold(
                key: scaffoldKeyFather,
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(60),
                  child: AppBarFather(),
                ),
                body: body(),
                endDrawer: FatherDrawer(),
                endDrawerEnableOpenDragGesture: false,
                bottomNavigationBar: BottomBar(),
              ),
            ]
        ));
  }

  /*************body**********/

  Widget body(){
    return Consumer<ProviderMasjed>(
      builder:(covtext,ProviderMasjed,x)=> Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20),
        child: ListView(
          children: [
            SizedBox(height: 30,),
            Text("اهلا بك ايها, الوالد",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.grey),),
            Text("اسم الابن",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.grey),),
            Name((ProviderMasjed.loginUser as Student_model).studentName),
            SizedBox(height: 40,),

            Text("اخر التحديثات",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.grey),),
            MohafethStudentComing("تسجيل تسميع اليوم",ProviderMasjed.daiyHefth==null?'0': ProviderMasjed.daiyHefth.first.pageNumber, "مقدار التسميع"),
            Text("الاختصارات",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.grey),),
            Row(
              children: [

                Expanded(
                  flex: 1,
                  child: StudentButtonScreen(
                      ImageIcon(
                        AssetImage("images/cup.png"),
                        color: Colors.black,
                        size: 40,
                      ),
                      "التقارير ",
                          () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (con)=>StudentScreenReport(Father(),FatherDrawer())));
                      }),
                ),
                Expanded(
                  flex: 1,
                  child: StudentButtonScreen(
                      Icon(Icons.image_search,
                        color: Colors.black,
                        size: 40,),
                      "الارشيف ",
                          () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (con)=>StudentDailyHefthScreen(Father(),FatherDrawer())));
                      }),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: StudentButtonScreen(
                      Icon(
                        Icons.card_giftcard,
                        color: Colors.black,
                        size: 40,
                      ),
                      "الاختبارات",
                          () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (con)=>StudentExamData(Father(),FatherDrawer())));
                      }),
                ),
                Expanded(
                  flex: 1,
                  child: StudentButtonScreen(
                      Icon(
                        Icons.people_alt_outlined,
                        color: Colors.black,
                        size: 40,
                      ),
                      "المحفظون ",
                          () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (con)=>StudentChain(Father(),FatherDrawer())));
                      }),
                ),

              ],
            )

          ],
        ),
      ),
    );
  }
}
