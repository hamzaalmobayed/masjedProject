import 'package:flutter/material.dart';
import 'package:masjed/MoshrefUi/drawer/drawer.dart';
import 'package:masjed/MoshrefUi/moshref/Moshref.dart';
import 'package:masjed/appBar.dart';
import 'package:masjed/provider.dart';
import 'package:provider/provider.dart';
import '../../bottomBar.dart';
import '../../generalBottomBar.dart';
BuildContext cont;
class Screen extends StatefulWidget {
  List<Widget> children;
  String txt;

  Screen(this.children, this.txt);

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initStates
    super.initState();
    Provider.of<ProviderMasjed>(context,listen: false).getMohafethFromFirestore();

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
      endDrawer: DrawerApp(),
      endDrawerEnableOpenDragGesture: false,
      bottomNavigationBar: GeneralBottomBar(Moshref()),
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
                  widget.txt,
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
            children: widget.children,
          ),
        )
      ],
    );
}
}
