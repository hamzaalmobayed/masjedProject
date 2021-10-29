import 'package:flutter/material.dart';
import 'package:masjed/provider.dart';
import 'package:provider/provider.dart';

import 'main.dart';
GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
class MainAppBar extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    bool visible=false;
    return Consumer<ProviderMasjed>(
        builder:(context,ProviderMasjed,x)=> AppBar(
        toolbarHeight: 60,
        backgroundColor: mainColor,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text("الصفحة الرئيسية",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
        ),
        actions: [
          Column(
            children: [
              SizedBox(height: 6,),
              Stack(
                children: [
                  IconButton(icon:Icon(Icons.notifications,color: Colors.white,size: 30,),onPressed: (){ProviderMasjed.changeVisibilty();print(ProviderMasjed.visible);},),
                  ProviderMasjed.countChats==0?SizedBox.shrink():Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                      alignment: Alignment.center,
                      child: Text(ProviderMasjed.countChats.toString()),
                    ),
                  ),

                ],
              ),
            ],
          ),
          IconButton(icon: ImageIcon(AssetImage("images/list.jpg"),color: Colors.white,size: 30,),onPressed: (){
            ProviderMasjed.visible=false;
            ProviderMasjed.notifyListeners();
            scaffoldKey.currentState.openEndDrawer();
          },),
          SizedBox(width: 10,)
        ],
      ),
    );
  }
}
