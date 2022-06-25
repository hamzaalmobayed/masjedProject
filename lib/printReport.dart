import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:masjed/appBar.dart';
import 'package:masjed/generalBottomBar.dart';
import 'package:masjed/main.dart';
import 'package:masjed/provider.dart';
import 'package:provider/provider.dart';

class PrintReport extends StatefulWidget {
  Widget widget;
  Widget drawer;
  PrintReport(this.widget, this.drawer);

  @override
  _PrintReportState createState() => _PrintReportState();
}

class _PrintReportState extends State<PrintReport> {
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
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RepaintBoundary(
                key: globalKey,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset('images/report.jpg'),
                    Positioned(
                        top: 107,
                        right: 120,
                        child: Container(
                          width: 200,
                          child: Center(
                            child: Text(
                              ProviderMasjed.conStudentReport.text,
                              style: TextStyle(color:mainColor, fontSize: 18),),
                          ),
                        )),
                    Positioned(
                        top: 150,
                        right: 156,
                        child: Container(
                          width: 172,
                          child: Center(
                            child: Text(
                              "01/"+ProviderMasjed.getMonth()+"/"+ProviderMasjed.getYear(),
                              style: TextStyle(color:mainColor, fontSize: 15),),
                          ),
                        )),
                    Positioned(
                        top: 282,
                        right: 156,
                        child: Container(
                          width: 172,
                          child: Center(
                            child: Text(
                              ProviderMasjed.pageNumber==null?"0":ProviderMasjed.pageNumber.toString(),
                              style: TextStyle(color:mainColor, fontSize: 15),),
                          ),
                        )),
                    Positioned(
                        top: 314,
                        right: 156,
                        child: Container(
                          width: 172,
                          child: Center(
                            child: Text(
                              ProviderMasjed.revisionPage==null?"0":ProviderMasjed.coming.toString(),
                              style: TextStyle(color:mainColor, fontSize: 15),),
                          ),
                        )),
                    Positioned(
                        top: 344,
                        right: 156,
                        child: Container(
                          width: 172,
                          child: Center(
                            child: Text(
                              ProviderMasjed.coming==null?"0":ProviderMasjed.coming.toString(),
                              style: TextStyle(color:mainColor, fontSize: 15),),
                          ),
                        )),
                    Positioned(
                        top: 370,
                        right: 156,
                        child: Container(
                          width: 172,
                          child: Center(
                            child: Text(
                              ProviderMasjed.assessment==null?"راسب":ProviderMasjed.assessment,
                              style: TextStyle(color:mainColor, fontSize: 15),),
                          ),
                        )),
                    Positioned(
                        top: 180,
                        right: 156,
                        child: Container(
                          width: 172,
                          child: Center(
                            child: Text(
                              ProviderMasjed.getDate(),
                              style: TextStyle(color:mainColor, fontSize: 15),),
                          ),
                        )),
                    Positioned(
                        top: 215,
                        right: 140,
                        child: Container(
                          width: 35,
                          child: Center(
                            child: Text(
                              ProviderMasjed.studentReports==null?"0":ProviderMasjed.studentReports.first.beginAya,
                              style: TextStyle(color:mainColor, fontSize: 15),),
                          ),
                        )),
                    Positioned(
                        top: 248,
                        right: 140,
                        child: Container(
                          width: 35,
                          child: Center(
                            child: Text(
                              ProviderMasjed.studentReports==null?"0":ProviderMasjed.studentReports.last.endAya,
                              style: TextStyle(color:mainColor, fontSize: 15),),
                          ),
                        )),
                    Positioned(
                        top: 248,
                        right: 235,
                        child: Container(
                          width: 80,
                          child: Center(
                            child: Text(
                              ProviderMasjed.studentReports==null?"0":ProviderMasjed.studentReports.last.endSora,
                              style: TextStyle(color:mainColor, fontSize: 15),),
                          ),
                        )),
                    Positioned(
                        top: 215,
                        right: 235,
                        child: Container(
                          width: 80,
                          child: Center(
                            child: Text(
                              ProviderMasjed.studentReports==null?"0":ProviderMasjed.studentReports.first.beginSora,
                              style: TextStyle(color:mainColor, fontSize: 15),),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              TextButton(
                onPressed: () {
                  ProviderMasjed.selectPdfType("report");
                  readImageData();
                  print(MediaQuery.of(context).size.width);
                  Future.delayed(Duration(seconds: 1))
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
