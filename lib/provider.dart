
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:masjed/firebase/storage.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:universal_html/html.dart' show AnchorElement;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:masjed/model/HefthModel.dart';

import 'firebase/authinitication.dart';
import 'model/ChainModel.dart';
import 'model/MohafethModel.dart';
import 'model/StudentModel.dart';
class ProviderMasjed extends ChangeNotifier{
  TextEditingController conName=TextEditingController();
  TextEditingController conBeginAya=TextEditingController();
  TextEditingController conBeginSora=TextEditingController();
  TextEditingController conEndAya=TextEditingController();
  TextEditingController conEndSora=TextEditingController();
  TextEditingController conPageNumber=TextEditingController();
  TextEditingController conRevisionPage=TextEditingController();
  TextEditingController conEstimate=TextEditingController();
  TextEditingController mohafethNameCon=TextEditingController();

  TextEditingController mohafethBirthdayCon=TextEditingController();
  TextEditingController mohafethFeildCon=TextEditingController();
  TextEditingController mohafethMobileCon=TextEditingController();

  TextEditingController studentNameCon=TextEditingController();
  TextEditingController CardCon=TextEditingController();
  TextEditingController studentBirthdayCon=TextEditingController();
  TextEditingController studentFatherCardCon=TextEditingController();
  TextEditingController studentMobileCon=TextEditingController();
  TextEditingController studentClassCon=TextEditingController();
  TextEditingController PasswordCon=TextEditingController();
  TextEditingController studentFatherWorkCon=TextEditingController();
  TextEditingController studentAddressCon=TextEditingController();
  TextEditingController searchingCon=TextEditingController();
  TextEditingController chainNumberCon=TextEditingController();
  TextEditingController chainNameCon=TextEditingController();
  Mohafeth_model mohafeth;
  Student_model student;
  List<String> mohafethStatusList=["حالة الاسرة","فقيرة","متوسطة","غنية"];
  String mohafethStatus="حالة الاسرة";
  String studentStatus="حالة الاسرة";
  List<String> mohafethCourseList=["دورات الاحكام","تمهيدية","تاهيلية","عليا","تاهيل سند","سند متصل"];
  String mohafethCourse="دورات الاحكام";
  String studentCourse="دورات الاحكام";
  int count=0;
  String valueStudent;
  List<Mohafeth_model> mohafeths;
  Mohafeth_model selectedMohafeth;
  final GlobalKey<State<StatefulWidget>> printKey = GlobalKey();

  change(){
    notifyListeners();
  }
  selectMohafeth( Mohafeth_model mohafeth){
    this.selectedMohafeth=mohafeth;
    notifyListeners();
  }
  getAllMohafeth()async{
    List<Mohafeth_model> mohafeth=await FireStore_Helper.FireStoreHelper.getAllMohafethFromFirestore();
    this.mohafeths=mohafeth;
    selectMohafeth(mohafeth.first);
    notifyListeners();
  }

  insertReport() async{
    Hefth_Model hefth=Hefth_Model(
      studentNameHefth: "conName3",
      beginAya:conBeginAya.text,
      beginSora:conBeginSora.text,
      endAya:conEndAya.text,
      endSora:conEndSora.text,
      pageNumber:conPageNumber.text,
      revisionPage:conRevisionPage.text,
      estimate:conEstimate.text,
    );
    await FireStore_Helper.FireStoreHelper.add("reports",hefth.toMap());
    print("done");
  }


  registerMohafeth() async {
    try {
      UserCredential userCredential = await Auth_Helper.authHelper
          .signup(CardCon.text,PasswordCon.text);
      mohafeth=Mohafeth_model(
        mohafethName:mohafethNameCon.text,
        mohafethIdCard:CardCon.text,
        birthDate:mohafethBirthdayCon.text,
        feild:mohafethFeildCon.text,
        mobile:mohafethMobileCon.text,
        familyStatus:mohafethStatus,
        password:PasswordCon.text,
        course:mohafethCourse,
      );
      await FireStore_Helper.FireStoreHelper.add("mohafeths",mohafeth.toMap());
      await Auth_Helper.authHelper.logout();

    } on Exception catch (e) {
      // TODO
    }
// navigate to login


  }
  add(table,map) async{
    await FireStore_Helper.FireStoreHelper.add(table,map);

  }

  registerStudent() async {
    try {
      UserCredential userCredential = await Auth_Helper.authHelper
          .signup(CardCon.text,PasswordCon.text);
      student=Student_model(
        studentName:studentNameCon.text,
        studentCard: CardCon.text,
        birthDate: studentBirthdayCon.text,
        fatherIdCard:studentFatherCardCon.text,
        fatherWork:studentFatherWorkCon.text,
        mobile:studentMobileCon.text,
        classRoom: studentClassCon.text,
        chainName: "hi",
        familyStatus:studentStatus,
        password:PasswordCon.text,
        address:studentAddressCon.text,
        course: studentCourse,
      );
      await FireStore_Helper.FireStoreHelper.add("students",student.toMap());
      await Auth_Helper.authHelper.logout();

    } on Exception catch (e) {
      // TODO
    }
// navigate to login


  }

  login() async {
    UserCredential userCredinial = await Auth_Helper.authHelper
        .signin(CardCon.text, PasswordCon.text);

  }

 logOut()async{
    await Auth_Helper.authHelper.logout();
 }




  Future<void> createExcelMohafeth() async
  {
    //Create a Excel document.
    //Creating a workbook.
    final Workbook workbook = Workbook();
    //Accessing via index.
    final Worksheet sheet = workbook.worksheets[0];

    // Set the text value.

    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await FirebaseFirestore.instance.collection('mohafeths').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<Mohafeth_model> mohafeth =
    docs.map((e) => Mohafeth_model.fromMap(e.data())).toList();
    mohafeth.forEach((element) {
      count=count+1;
      print(element.mohafethName);
      sheet.getRangeByName('A'+count.toString()).setText(element.mohafethName);
      sheet.getRangeByName('B'+count.toString()).setText(element.mohafethIdCard);
      sheet.getRangeByName('C'+count.toString()).setText(element.birthDate);
      sheet.getRangeByName('D'+count.toString()).setText(element.feild);
      sheet.getRangeByName('E'+count.toString()).setText(element.mobile);
      sheet.getRangeByName('G'+count.toString()).setText(element.familyStatus);
      sheet.getRangeByName('H'+count.toString()).setText(element.password);
      sheet.getRangeByName('I'+count.toString()).setText(element.course);
      print("done"+count.toString());
    });

    count=0;




    //Save and launch the excel.
    final List<int> bytes = workbook.saveAsStream();
    //Dispose the document.
    workbook.dispose();
    if (kIsWeb) {
      AnchorElement(
          href:
          'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
        ..setAttribute('download', 'Output.xlsx')
        ..click();
    } else {
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName =
      Platform.isWindows ? '$path\\Output.xlsx' : '$path/Output.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);
    }

  }
  Future<void> createExcelStudent() async
  {
    //Create a Excel document.
    //Creating a workbook.
    final Workbook workbook = Workbook();
    //Accessing via index.
    final Worksheet sheet = workbook.worksheets[0];
    // Set the text value.
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await FirebaseFirestore.instance.collection('students').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<Student_model> mohafeth =
    docs.map((e) => Student_model.fromMap(e.data())).toList();
    mohafeth.forEach((element) {
      count=count+1;
      print(element.studentName);
      sheet.getRangeByName('A'+count.toString()).setText(element.studentName);
      sheet.getRangeByName('B'+count.toString()).setText(element.studentCard);
      sheet.getRangeByName('C'+count.toString()).setText(element.birthDate);
      sheet.getRangeByName('D'+count.toString()).setText(element.fatherIdCard);
      sheet.getRangeByName('E'+count.toString()).setText(element.mobile);
      sheet.getRangeByName('F'+count.toString()).setText(element.classRoom);
      sheet.getRangeByName('F'+count.toString()).setText(element.chainName);
      sheet.getRangeByName('G'+count.toString()).setText(element.familyStatus);
      sheet.getRangeByName('H'+count.toString()).setText(element.password);
      sheet.getRangeByName('G'+count.toString()).setText(element.address);
      sheet.getRangeByName('G'+count.toString()).setText(element.fatherWork);
      sheet.getRangeByName('I'+count.toString()).setText(element.course);
      print("done"+count.toString());
    });

    count=0;

    //Save and launch the excel.
    final List<int> bytes = workbook.saveAsStream();
    //Dispose the document.
    workbook.dispose();
    if (kIsWeb) {
      AnchorElement(
          href:
          'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
        ..setAttribute('download', 'Output.xlsx')
        ..click();
    } else {
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName =
      Platform.isWindows ? '$path\\Output.xlsx' : '$path/Output.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);
    }

  }
  Future<void> createExcelChain() async
  {
    //Create a Excel document.
    //Creating a workbook.
    final Workbook workbook = Workbook();
    //Accessing via index.
    final Worksheet sheet = workbook.worksheets[0];
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await FirebaseFirestore.instance.collection('chains').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<Chain_model> mohafeth =
    docs.map((e) => Chain_model.fromMap(e.data())).toList();
    mohafeth.forEach((element) {
      count=count+1;
      sheet.getRangeByName('A'+count.toString()).setText(element.chainName);
      sheet.getRangeByName('B'+count.toString()).setText(element.chainMohafeth);
      sheet.getRangeByName('C'+count.toString()).setText(element.chainhelper);
      sheet.getRangeByName('D'+count.toString()).setText(element.age);
      sheet.getRangeByName('E'+count.toString()).setText(element.number);
      print("done"+count.toString());
      print("done"+count.toString());
    });

    count=0;
    // Set the text value.
    //Save and launch the excel.
    final List<int> bytes = workbook.saveAsStream();
    //Dispose the document.
    workbook.dispose();
    if (kIsWeb) {
      AnchorElement(
          href:
          'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
        ..setAttribute('download', 'Output.xlsx')
        ..click();
    } else {
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName =
      Platform.isWindows ? '$path\\Output.xlsx' : '$path/Output.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);
    }

  }
  Future<void> createExcelExam() async
  {
    //Create a Excel document.
    //Creating a workbook.
    final Workbook workbook = Workbook();
    //Accessing via index.
    final Worksheet sheet = workbook.worksheets[0];
    // Set the text value.
    for(int i=0;i<5;i++){
      count=i+1;
      sheet.getRangeByName('A'+count.toString()).setText('ابو بكر');
      sheet.getRangeByName('B'+count.toString()).setText('احمد اهل');
      sheet.getRangeByName('C'+count.toString()).setText('قد سمع');
      sheet.getRangeByName('D'+count.toString()).setText('90');
      sheet.getRangeByName('E'+count.toString()).setText('ممتاز');
      sheet.getRangeByName('F'+count.toString()).setText('1/4/2021');
      sheet.getRangeByName('F'+count.toString()).setText('ابو بكر');
      print("done"+count.toString());
    }
    //Save and launch the excel.
    final List<int> bytes = workbook.saveAsStream();
    //Dispose the document.
    workbook.dispose();
    if (kIsWeb) {
      AnchorElement(
          href:
          'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
        ..setAttribute('download', 'Output.xlsx')
        ..click();
    } else {
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName =
      Platform.isWindows ? '$path\\Output.xlsx' : '$path/Output.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);
    }

  }
  Future<void> createExcelComing() async
  {
    //Create a Excel document.
    //Creating a workbook.
    final Workbook workbook = Workbook();
    //Accessing via index.
    final Worksheet sheet = workbook.worksheets[0];
    // Set the text value.
    for(int i=0;i<5;i++){
      count=i+1;
      sheet.getRangeByName('A'+count.toString()).setText('احمد اهل');
      sheet.getRangeByName('B'+count.toString()).setText('حاضر');
      sheet.getRangeByName('C'+count.toString()).setText('1/2/1999');

      print("done"+count.toString());
    }
    //Save and launch the excel.
    final List<int> bytes = workbook.saveAsStream();
    //Dispose the document.
    workbook.dispose();
    if (kIsWeb) {
      AnchorElement(
          href:
          'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
        ..setAttribute('download', 'Output.xlsx')
        ..click();
    } else {
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName =
      Platform.isWindows ? '$path\\Output.xlsx' : '$path/Output.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);
    }

  }


  Future<void> createPDF() async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();



    page.graphics.drawImage(
        PdfBitmap(await _readImageData('certification.jpg')),
        Rect.fromLTWH(0, 0, 500, 550));



    List<int> bytes = document.save();
    document.dispose();
    if (kIsWeb) {
      saveAndLaunchFileWeb(bytes, 'Output.pdf');
    }else{
      saveAndLaunchFileMobile(bytes, 'Output.pdf');
    }

  }


Future<Uint8List> _readImageData(String name) async {
  final data = await rootBundle.load('images/$name');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}
  Future<void> saveAndLaunchFileMobile(List<int> bytes, String fileName) async {
    final path = (await getExternalStorageDirectory()).path;
    final file = File('$path/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open('$path/$fileName');
  }
  Future<void> saveAndLaunchFileWeb(List<int> bytes, String fileName) async {
    AnchorElement(
        href:
        "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
      ..setAttribute("download", fileName)
      ..click();
  }
  user() async{
    return await Auth_Helper.authHelper.user();
  }

}
