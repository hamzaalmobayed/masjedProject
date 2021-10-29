import 'package:flutter/cupertino.dart';
import'package:flutter/material.dart';
import 'package:masjed/MoshrefUi/drawer/drawer.dart';
import 'package:masjed/generalBottomBar.dart';
import 'package:masjed/main.dart';
import 'package:masjed/MoshrefUi/moshref/Moshref.dart';
import 'package:masjed/provider.dart';
import 'package:provider/provider.dart';

import '../../appBar.dart';
import '../../bottomBar.dart';
class Message extends StatefulWidget {
  Widget back;
  Widget drawer;

  Message(this.back, this.drawer);

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void initState() {
    super.initState();
    Provider.of<ProviderMasjed>(context,listen: false).conMessage.clear();
    Provider.of<ProviderMasjed>(context,listen: false).persons.clear();
    Provider.of<ProviderMasjed>(context,listen: false).getPersons();
    Provider.of<ProviderMasjed>(context,listen: false).getLoginUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar:PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: appBar(),
      ) ,
      body: body(),
      endDrawer: widget.drawer,
      endDrawerEnableOpenDragGesture: false,
      bottomNavigationBar: GeneralBottomBar(widget.back),
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
    return Consumer<ProviderMasjed>(
      builder:(context,ProviderMasjed,x)=> SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 11.0,right: 11,top: 60),
          child: Container(
            height: 460,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(flex:2,child: Text("ارسال ل",style:TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 20))),
                        Expanded(flex:6,child: Padding(
                          padding: const EdgeInsets.only(top: 10.0,left: 4),
                          child: Container(
                            width: 180,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.fromBorderSide(BorderSide(width: 1,)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 10.0,
                                ),
                              ],),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                underline: SizedBox(),
                                icon: Icon(Icons.keyboard_arrow_down_sharp),
                                iconSize: 30,
                                items: ProviderMasjed.persons.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Center(child: new Text(value,style: TextStyle(fontSize: 12,),)),
                                  );
                                }).toList(),
                                onChanged: (v) {
                                  ProviderMasjed.selectPerson(v);
                                },
                                value:  ProviderMasjed.selectedPerson,
                              ),
                            ),
                          ),
                        ),),

                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("نص الرسالة",style:TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 20)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
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
                      maxLines: 8,
                      controller: ProviderMasjed.conMessage,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "اكتب رسالتك",
                        contentPadding: EdgeInsets.only(right: 8),
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
                      ProviderMasjed.addMessage();
                    }, child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 125),
                  child: Text("ارسال",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
