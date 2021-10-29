import 'package:flutter/material.dart';
import 'package:masjed/MohafethUi/Mohafeth/mohafeth.dart';
import 'package:masjed/MohafethUi/studentDataShow/studentMohafethDataShow.dart';
import 'package:masjed/MoshrefUi/dataProcessScreen/ProcessButton.dart';
import 'package:masjed/MoshrefUi/drawer/drawer.dart';
import 'package:masjed/MoshrefUi/drawer/mohafethDrawer.dart';
import 'package:masjed/MoshrefUi/drawer/studentDrawer.dart';
import 'package:masjed/MoshrefUi/moshref/Moshref.dart';
import 'package:masjed/MoshrefUi/searching/searching.dart';
import 'package:masjed/MoshrefUi/studentDataShow/studentDataShow.dart';
import 'package:masjed/appBar.dart';
import 'package:masjed/provider.dart';
import 'package:provider/provider.dart';
import '../../bottomBar.dart';
import '../../generalBottomBar.dart';
BuildContext cont;
class StudentData extends StatefulWidget {

  @override
  _StudentDataState createState() => _StudentDataState();
}

class _StudentDataState extends State<StudentData> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void initState() {
    super.initState();
      Provider.of<ProviderMasjed>(context,listen: false).getMohafethChainFromFirestore();
      Provider.of<ProviderMasjed>(context,listen: false).getStudentChainFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    cont=context;
    return Scaffold(
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
      "",
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
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 60.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  "بيانات الطلاب",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black.withOpacity(0.9)),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              ProcessButton(
                  Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 30,
                  ),
                  "البحث عن بيانات الطلاب",
                      () {
                    Navigator.of(cont).pushReplacement(MaterialPageRoute(builder: (con)=>Searching("ادخل اسم طالب",MohafethDrawer())));
                  }),
              ProcessButton(
                  Icon(
                    Icons.remove_red_eye,
                    color: Colors.black,
                    size: 30,
                  ),
                  "عرض كافة الطلاب",
                      () {
                    Navigator.of(cont).pushReplacement(
                        MaterialPageRoute(
                            builder: (con) =>StudentMohafethDataShow(StudentData(),MohafethDrawer())));
                  }),
              Consumer<ProviderMasjed>(
                builder: (context,ProviderMasjed,x)=>ProcessButton(
                    Icon(
                      Icons.assessment,
                      color: Colors.black,
                      size: 30,
                    ),
                    "تصدير بيانات الطلاب",
                        () {
                      ProviderMasjed.createExcelStudentChain();
                        }),
              ),
            ],
          ),
        )
      ],
    );
  }
}
