import 'package:flutter/material.dart';
import 'package:masjed/main.dart';
import 'package:masjed/provider.dart';
import 'package:provider/provider.dart';


GlobalKey<ScaffoldState> scaffoldKeyFather = new GlobalKey<ScaffoldState>();
class AppBarFather extends StatelessWidget {


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
          IconButton(icon: ImageIcon(AssetImage("images/list.jpg"),color: Colors.white,size: 30,),onPressed: (){
            ProviderMasjed.visible=false;
            ProviderMasjed.notifyListeners();
            scaffoldKeyFather.currentState.openEndDrawer();
          },),
          SizedBox(width: 10,)
        ],
      ),
    );
  }
}
