import 'package:flutter/cupertino.dart';
import'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:masjed/MoshrefUi/drawer/drawer.dart';
import 'package:masjed/generalBottomBar.dart';
import 'package:masjed/main.dart';
import 'package:masjed/MoshrefUi/moshref/Moshref.dart';
import 'package:masjed/provider.dart';
import 'package:provider/provider.dart';

import '../../appBar.dart';
import '../../bottomBar.dart';
class ShowMessage extends StatefulWidget {
  Widget back;
  Widget drawer;

  ShowMessage(this.back, this.drawer);

  @override
  _ShowMessageState createState() => _ShowMessageState();
}

class _ShowMessageState extends State<ShowMessage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void initState() {
    super.initState();
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
      bottomNavigationBar:BottomBar(),
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
      builder:(context,ProviderMasjed,x)=> Padding(
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
                padding: const EdgeInsets.only(right: 20.0,top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(ProviderMasjed.selectedChat.sender,style:TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 20)),
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
                    enabled: false,
                    readOnly: true,
                    controller: ProviderMasjed.conMessage,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: ProviderMasjed.selectedChat.text,
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
                padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 95),
                child: Text("?????? ??????????????",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
