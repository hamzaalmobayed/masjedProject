import 'package:flutter/material.dart';
import 'package:masjed/MohafethUi/Mohafeth/mohafethStudentComing.dart';
import 'package:masjed/MohafethUi/studentExam/studentExam.dart';
import 'package:masjed/MoshrefUi/drawer/drawerButton.dart';
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
import 'package:masjed/main.dart';
import 'package:masjed/model/StudentModel.dart';
import 'package:masjed/triangle.dart';
import 'package:provider/provider.dart';

import '../../mainAppBar.dart';
import '../../provider.dart';
class Student extends StatefulWidget {

  @override
  _StudentState createState() => _StudentState();
}

class _StudentState extends State<Student> {
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
                key: scaffoldKey,
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(60),
                  child: MainAppBar(),
                ),
                body: body(),
                endDrawer: StudentDrawer(),
                endDrawerEnableOpenDragGesture: false,
                bottomNavigationBar: BottomBar(),
              ),
              Visibility(
                visible: ProviderMasjed.visible,
                child: Positioned(
                  top: 70,
                  left:40,
                  child: Material(
                    color: Colors.white.withOpacity(0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,

                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 27),
                          child: CustomPaint(
                            painter: TrianglePainter(
                              strokeColor: Colors.white,
                              strokeWidth: 10,
                              paintingStyle: PaintingStyle.fill,
                            ),
                            child: Container(
                              height: 20,
                              width: 30,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 1.0), //(x,y)
                                blurRadius: 10.0,
                              ),
                            ],
                          ),
                          width: 250,
                          height: 200,
                          child: SingleChildScrollView(

                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  children: ProviderMasjed.chats.map((e) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextButton(
                                      onPressed: (){
                                        ProviderMasjed.selectMessage(e);
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                  backgroundColor:Colors.white,
                                                  contentPadding: EdgeInsets.zero,
                                                  content:Builder(
                                                      builder:(con) {
                                                        var height = MediaQuery.of(context).size.height;
                                                        var width = MediaQuery.of(context).size.width;
                                                        return Container(
                                                          height: height-400,
                                                          width: width+100,
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets.only(right: 20.0,top: 20),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: [
                                                                    Text(ProviderMasjed.selectedChat.sender,style:TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 18)),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                                                child: Container(
                                                                  width: double.infinity,

                                                                  decoration: BoxDecoration(
                                                                    border: Border.fromBorderSide(BorderSide(width: 1,color: Colors.black)),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: Colors.grey,
                                                                        offset: Offset(0.0, 1.0), //(x,y)
                                                                        blurRadius: 10.0,
                                                                      ),
                                                                    ],
                                                                    color: Colors.white,
                                                                  ),
                                                                  child:TextField(
                                                                    maxLines: 5,
                                                                    enabled: false,
                                                                    readOnly: true,
                                                                    controller: ProviderMasjed.conMessage,
                                                                    decoration: InputDecoration(
                                                                      border: InputBorder.none,
                                                                      hintText: ProviderMasjed.selectedChat.text,
                                                                      contentPadding: EdgeInsets.symmetric(horizontal:  20),
                                                                      hintStyle:TextStyle(color: Colors.grey,fontSize: 20),
                                                                    ),
                                                                  ) ,
                                                                ),
                                                              ),
                                                              ElevatedButton(
                                                                  style: ButtonStyle(
                                                                      backgroundColor: MaterialStateProperty.all(mainColor)
                                                                  ) ,
                                                                  onPressed: (){
                                                                    Navigator.of(context).pop();
                                                                  }, child: Padding(
                                                                padding:  EdgeInsets.symmetric(vertical: 12.0,horizontal: 75),
                                                                child: Text("تمت القراءة",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                                                              )),
                                                            ],
                                                          ),
                                                        );}
                                                  )

                                              );
                                            });
                                      },
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(e.date,style: TextStyle(fontSize: 18,color: Colors.blue),),
                                          Text(e.sender,style: TextStyle(fontSize: 18,color: Colors.grey),),
                                          Divider(color: mainColor,height: 2,thickness: 2,),
                                        ],
                                      ),
                                    ),
                                  )).toList()
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
            SizedBox(height: 50,),
            Text("اهلا بك, الطالب",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.grey),),
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
                        AssetImage("images/sheet.png"),
                        color: Colors.black,
                        size: 40,
                      ),
                      "بياناتي",
                          () {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (con)=>StudentDataShowScreen(Student())));
                          }),
                ),
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
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (con)=>StudentScreenReport(Student(),StudentDrawer())));
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
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (con)=>StudentDailyHefthScreen(Student(),StudentDrawer())));
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
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (con)=>StudentExamData(Student(),StudentDrawer())));
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
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (con)=>StudentChain(Student(),StudentDrawer())));
                          }),
                ),
                Expanded(
                  flex: 1,
                  child: StudentButtonScreen(
                      Icon(Icons.notifications_none,
                        color: Colors.black,
                        size: 40,),
                      "الاشعارات ",
                          () {
                            ProviderMasjed.changeVisibilty();print(ProviderMasjed.visible);
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
