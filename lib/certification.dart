import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:masjed/appBar.dart';
import 'package:masjed/generalBottomBar.dart';
import 'package:masjed/main.dart';
import 'package:masjed/provider.dart';
import 'package:provider/provider.dart';

class PngHome extends StatefulWidget {
  Widget widget;
  Widget drawer;
  PngHome(this.widget, this.drawer);

  @override
  _PngHomeState createState() => _PngHomeState();
}

class _PngHomeState extends State<PngHome> {
  GlobalKey globalKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<void> readImageData() async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    Provider.of<ProviderMasjed>(context, listen: false).imageUi = pngBytes;
    print(pngBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderMasjed>(builder: (context, ProviderMasjed, x) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: appBar(),
        ),
        endDrawer: widget.drawer,
        endDrawerEnableOpenDragGesture: false,
        bottomNavigationBar: GeneralBottomBar(widget.widget),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RepaintBoundary(
              key: globalKey,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('images/certification.jpg'),
                  Positioned(
                    top: 100,
                    right: 0,
                    child: Container(
                      width: 360,
                      child: Center(
                        child: Text(
                          ProviderMasjed.pressedExam.studentName,
                          style: TextStyle(color:mainColor, fontSize: 18),),
                      ),
                    )),
                  Positioned(
                      top: 120,
                      right: 100,
                      child: Container(
                        child: Text(
                            ProviderMasjed.pressedExam.examName,
                          style: TextStyle(color:mainColor, fontSize: 15),),
                      )),
                  Positioned(
                      top: 142,
                      right: 210,
                      child: Container(
                        child: Text(
                          ProviderMasjed.pressedExam.estimation,
                          style: TextStyle(color:mainColor, fontSize: 15),),
                      )),
                  Positioned(
                      top: 142,
                      left: 50,
                      child: Text(
                        ProviderMasjed.pressedExam.grade,
                        style: TextStyle(color:mainColor, fontSize: 15),)),

                ],
              ),
            ),
            SizedBox(height: 30,),
            TextButton(
                onPressed: () {
                  ProviderMasjed.selectPdfType("certification");
                  readImageData();
                  print(MediaQuery.of(context).size.width);
                  Future.delayed(Duration(seconds: 2))
                      .then((value) => ProviderMasjed.createPDF());
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "تنزيل",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              style: TextButton.styleFrom(
                backgroundColor: mainColor,
            ),
            )
          ],
        ),
      );
    });
  }

  /*************appBar**********/
  Widget appBar() {
    return AppBarCustom(
      "الشهادة",
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
}
