import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:masjed/bottomBar.dart';
import 'package:masjed/MoshrefUi/drawer/drawer.dart';
import 'package:masjed/main.dart';
import 'package:masjed/MoshrefUi/moshref/name.dart';
import 'package:masjed/MoshrefUi/moshref/number.dart';
import 'package:masjed/mainAppBar.dart';
import 'package:masjed/model/MoshrefModel.dart';
import 'package:masjed/provider.dart';
import 'package:masjed/showMessage.dart';
import 'package:masjed/triangle.dart';
import 'package:provider/provider.dart';
class Moshref extends StatefulWidget {

  @override
  _MoshrefState createState() => _MoshrefState();
}

class _MoshrefState extends State<Moshref> {
  void initState() {
    super.initState();
    Provider.of<ProviderMasjed>(context,listen: false).getChainFromFirestore();
    Provider.of<ProviderMasjed>(context,listen: false).getMohafethFromFirestore();
    Provider.of<ProviderMasjed>(context,listen: false).getStudentFromFirestore();
    Provider.of<ProviderMasjed>(context,listen: false).getAllReports();
    Provider.of<ProviderMasjed>(context,listen: false).getChainFromFirestore();
    Provider.of<ProviderMasjed>(context,listen: false).getmohafethComing();
    Provider.of<ProviderMasjed>(context,listen: false).getAllChats();
    print(Provider.of<ProviderMasjed>(context,listen: false).visible.toString()+'*/*/*/*');

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderMasjed>(
        builder: (context,ProviderMasjed,x)=>Stack(
      children: [
        Scaffold(
        key: scaffoldKey,
        appBar:  PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: MainAppBar(),
        ),
        body: body(),
        endDrawer: DrawerApp(),
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
      builder:(context,ProviderMasjed,x){
        return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20),
        child: ListView(
          children: [
            SizedBox(height: 50,),
            Text("اهلا بك, مشرف الحلقات",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.grey),),
            Name((ProviderMasjed.loginUser as Moshref_model).moshrefName),
            SizedBox(height: 60,),

            Text("اخر التحديثات",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.grey),),
            Number("احصائية حضور الطلاب",ProviderMasjed.allReports==null?"0":ProviderMasjed.allReports.length.toString(), "طالب", ProviderMasjed.students.length.toString()),
            Number("احصائية حضور المحفظين",ProviderMasjed.mohafethComing==null?"0":ProviderMasjed.mohafethComing.length.toString(), "محفظ",ProviderMasjed.mohafeths.length.toString() ),

          ],
        ),
      );}
    );
  }
}
