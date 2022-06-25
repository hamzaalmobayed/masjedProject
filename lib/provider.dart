import 'package:flutter/rendering.dart';
import 'package:image/image.dart';
import 'dart:ui' as ui;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:masjed/firebase/storage.dart';
import 'package:masjed/main.dart';
import 'package:masjed/model/ChatModel.dart';
import 'package:masjed/model/ExamModel.dart';
import 'package:masjed/model/MoshrefModel.dart';
import 'package:masjed/sharedPreferences.dart';
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
import 'model/ComingModel.dart';
import 'model/HafethModel.dart';
import 'model/MohafethModel.dart';
import 'model/StudentModel.dart';
class ProviderMasjed extends ChangeNotifier{
  ProviderMasjed() {
    getMohafethFromFirestore();
    getChainFromFirestore();
    getStudentFromFirestore();
    getAge();
    getStatus();
    getCourse();

  }
  bool isComing=true;
  String pressedStudentName;
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
  TextEditingController mohafethStatusCon=TextEditingController();
  TextEditingController mohafethCourseCon=TextEditingController();

  TextEditingController mohafethBirthdayCon1=TextEditingController();
  TextEditingController mohafethNameCon1=TextEditingController();
  TextEditingController mohafethFeildCon1=TextEditingController();
  TextEditingController mohafethMobileCon1=TextEditingController();
  TextEditingController mohafethStatusCon1=TextEditingController();
  TextEditingController mohafethCourseCon1=TextEditingController();
  TextEditingController mohafethPasswordCon1=TextEditingController();
  TextEditingController CardCon1=TextEditingController();

  TextEditingController hafethBirthdayCon1=TextEditingController();
  TextEditingController hafethNameCon1=TextEditingController();
  TextEditingController hafethFeildCon1=TextEditingController();
  TextEditingController hafethMobileCon1=TextEditingController();
  TextEditingController hafethMohafethCon1=TextEditingController();
  TextEditingController hafethDateCon1=TextEditingController();
  TextEditingController hafethCardCon1=TextEditingController();
  TextEditingController hafethStatusCon1=TextEditingController();
  TextEditingController hafethCourseCon1=TextEditingController();
  TextEditingController hafethHefthCon1=TextEditingController();

  TextEditingController mohafethBirthdayCon2=TextEditingController();
  TextEditingController mohafethNameCon2=TextEditingController();
  TextEditingController mohafethFeildCon2=TextEditingController();
  TextEditingController mohafethMobileCon2=TextEditingController();
  TextEditingController mohafethStatusCon2=TextEditingController();
  TextEditingController mohafethCourseCon2=TextEditingController();
  TextEditingController mohafethPasswordCon2=TextEditingController();
  TextEditingController CardCon2=TextEditingController();

  TextEditingController hafethBirthdayCon2=TextEditingController();
  TextEditingController hafethNameCon2=TextEditingController();
  TextEditingController hafethFeildCon2=TextEditingController();
  TextEditingController hafethMobileCon2=TextEditingController();
  TextEditingController hafethStatusCon2=TextEditingController();
  TextEditingController hafethCourseCon2=TextEditingController();
  TextEditingController hafethMohafethCon2=TextEditingController();
  TextEditingController hafethCardCon2=TextEditingController();
  TextEditingController hafethDateCon2=TextEditingController();
  TextEditingController hafethHefthCon2=TextEditingController();

  bool visible=false;
  TextEditingController studentNameCon=TextEditingController();
  TextEditingController CardCon=TextEditingController();
  TextEditingController studentBirthdayCon=TextEditingController();
  TextEditingController studentFatherCardCon=TextEditingController();
  TextEditingController studentMobileCon=TextEditingController();
  TextEditingController studentClassCon=TextEditingController();
  TextEditingController PasswordCon=TextEditingController();
  TextEditingController studentFatherWorkCon=TextEditingController();
  TextEditingController studentAddressCon=TextEditingController();

  TextEditingController studentNameCon1=TextEditingController();
  TextEditingController studentCardCon1=TextEditingController();
  TextEditingController studentBirthdayCon1=TextEditingController();
  TextEditingController studentFatherCardCon1=TextEditingController();
  TextEditingController studentMobileCon1=TextEditingController();
  TextEditingController studentChainCon1=TextEditingController();
  TextEditingController studentClassCon1=TextEditingController();
  TextEditingController studentPasswordCon1=TextEditingController();
  TextEditingController studentFatherWorkCon1=TextEditingController();
  TextEditingController studentAddressCon1=TextEditingController();
  TextEditingController studentStatusCon1=TextEditingController();
  TextEditingController studentCourseCon1=TextEditingController();
  TextEditingController studentStatusCon11=TextEditingController();
  TextEditingController studentCourseCon11=TextEditingController();
  TextEditingController studentChainCon11=TextEditingController();

  TextEditingController chainNumberCon1=TextEditingController();
  TextEditingController chainNameCon1=TextEditingController();
  TextEditingController chainAgeCon1=TextEditingController();
  TextEditingController chainMohafethCon1=TextEditingController();
  TextEditingController chainHelperCon1=TextEditingController();
  TextEditingController chainAgeCon11=TextEditingController();
  TextEditingController chainMohafethCon11=TextEditingController();
  TextEditingController chainHelperCon11=TextEditingController();

  TextEditingController searchingCon=TextEditingController();

  TextEditingController conExamChain=TextEditingController();
  TextEditingController chainNumberCon=TextEditingController();
  TextEditingController chainNameCon=TextEditingController();
  TextEditingController conExamName=TextEditingController();
  TextEditingController conExamMark=TextEditingController();
  TextEditingController conExamEstimation=TextEditingController();
  TextEditingController conExamDate=TextEditingController();
  TextEditingController conExamPerson=TextEditingController();

  TextEditingController conExamChain1=TextEditingController();
  TextEditingController conExamStudent1=TextEditingController();

  TextEditingController conExamName1=TextEditingController();
  TextEditingController conExamMark1=TextEditingController();
  TextEditingController conExamEstimation1=TextEditingController();
  TextEditingController conExamDate1=TextEditingController();
  TextEditingController conExamPerson1=TextEditingController();

  TextEditingController conExamChain11=TextEditingController();
  TextEditingController conExamStudent11=TextEditingController();

  TextEditingController conLoginCard=TextEditingController();
  TextEditingController conLoginPassword=TextEditingController();
  TextEditingController conMessage=TextEditingController();
  TextEditingController conStudentReport=TextEditingController();

  TextEditingController moshrefNameCon=TextEditingController();
  TextEditingController moshrefIdCardCon=TextEditingController();
  TextEditingController moshrefbirthDateCon=TextEditingController();
  TextEditingController moshreffeildCon=TextEditingController();
  TextEditingController moshrefmobileCon=TextEditingController();
  TextEditingController moshrefjobCon=TextEditingController();
  TextEditingController moshreffamilyStatusCon=TextEditingController();
  TextEditingController moshrefpasswordCon=TextEditingController();
  Mohafeth_model mohafeth;
  Student_model student;
  List<String> StatusList;
  String selectedStatus;
  List<String> CourseList;
  String selectedCourse;
  Chain_model pressedChain;
  Student_model pressedStudent;
  Hefth_Model pressedHistory;
  int count=0;
  String valueStudent;
  dynamic loginUser;
  dynamic saveLogin;
  int i=0;
  int comingCount=0;
  int hefthCount=0;
  int revisionCount=0;
  String best='';
  int studentNumber=0;
  increaseComingCount(){
    ++comingCount;
    notifyListeners();
  }
  List<Mohafeth_model> mohafeths;
  List<Mohafeth_model> helperMohafeths;
  Mohafeth_model selectedMohafeth;
  List<Chain_model> mohafethChain;
  List<String> persons=[];
  Exam_model pressedExam;
  getPressedExam(Exam_model exam){
    this.pressedExam=exam;
    notifyListeners();
  }
  Mohafeth_model pressedMohafeth;
  getPressedMohafeth(Mohafeth_model mohafeth){
    this.pressedMohafeth=mohafeth;
    notifyListeners();
  }
  Hafeth_model pressedHafeth;
  getPressedHafeth(Hafeth_model Hafeth){
    this.pressedHafeth=Hafeth;
    notifyListeners();
  }
  Student_model pressedStudentShow;
  getPressedStudent(Student_model pressedStudent){
    this.pressedStudentShow=pressedStudent;
    notifyListeners();
  }
  Chain_model pressedChainShow;
  getPressedChain(Chain_model pressedChain){
    this.pressedChainShow=pressedChain;
    notifyListeners();
  }
  getDate(){
    var now = new DateTime.now();
    var formatter = new DateFormat('dd/MM/yyyy');
    String date = formatter.format(now);
    return date;
  }
  changeVisibilty(){
    this.visible=!this.visible;
    notifyListeners();
  }
  getYear(){
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy');
    String year = formatter.format(now);
    return year;
  }
  getAgeOfStudent(Student_model s){
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy');
    int yearNow = int.parse(formatter.format(now));
    int yearStudent=int.parse(s.birthDate.split('/').last);
    return yearNow-yearStudent;
  }
  getMonth(){
    var now = new DateTime.now();
    var formatter = new DateFormat('MM');
    String month = formatter.format(now);
    return month;
  }
  List<Student_model> allStudents;
  List<Mohafeth_model> allMohafeths;
  List<Moshref_model> allMoshref;
  String cardType;
  getPersons()async{
    List<Student_model> students =
    await FireStore_Helper.FireStoreHelper.getAllStudentFromFirestore();
    List<Mohafeth_model> mohafeths =
    await FireStore_Helper.FireStoreHelper.getAllMohafethFromFirestore();
    List<Moshref_model> moshref =
    await FireStore_Helper.FireStoreHelper.getMoshrefFromFirestore();
    this.allStudents=students;
    this.allMohafeths=mohafeths;
    this.allMoshref=moshref;
    notifyListeners();
  }

  getLoginUser()async{
    print('begin /*/*/*');
    this.allMoshref.forEach((element) {
      persons.add(element.moshrefName);
      if(conLoginCard.text==element.moshrefIdCard&&conLoginPassword.text==element.password){
        this.loginUser=element;
      }
    });
    this.allStudents.forEach((element) {
      print(element.studentName+element.studentCard+element.password);
      persons.add(element.studentName);
      print(conLoginCard.text.toString()+conLoginPassword.text.toString());
      if(conLoginCard.text==element.studentCard&&conLoginPassword.text==element.password){
        this.loginUser=element;
        cardType="student";
        Helper.x.saveStudentType(cardType);
      }else if(conLoginCard.text==element.fatherIdCard&&conLoginPassword.text==element.mobile){
        this.loginUser=element;
        cardType="father";
        Helper.x.saveStudentType(cardType);
      }
    });

    this.allMohafeths.forEach((element) {
      persons.add(element.mohafethName);
      if(conLoginCard.text==element.mohafethIdCard&&conLoginPassword.text==element.password){
        this.loginUser=element;
      }
    });
    Helper.x.saveUser("login", this.loginUser);
    print("555555"+Helper.x.getType());
    persons.forEach((element) {
      print(element);
    });
    selectPerson(persons.first);
    notifyListeners();
    print(this.loginUser+'this is login user');
    print(this.loginUser.runtimeType.toString()+'this is login user type');

  }
  String selectedPerson;
  selectPerson(String person){
    this.selectedPerson=person;
    print(selectedPerson);
    notifyListeners();
  }
  selectMohafeth(Mohafeth_model mohafethModel) {
    this.selectedMohafeth = mohafethModel;
    notifyListeners();
  }
  Student_model selectedChainStudent;
  Hefth_Model selectedReport;
  List<Hefth_Model> reportHistory;
  selectChainStudent(Student_model student) async{
    this.selectedChainStudent = student;
    notifyListeners();
    List<Exam_model> examHistory =
        await FireStore_Helper.FireStoreHelper.getStudentExamHistoryFromFirestore(this.selectedChainStudent.studentName);
      this.examHistory = examHistory;
    notifyListeners();
    selectExamHistory(examHistory.first);
    notifyListeners();
  }
  void onChange() {
    notifyListeners();
  }
  List<Chain_model> chains;
  List<Student_model> chainStudent ;
  Chain_model selectedChain;
  selectChain(Chain_model chainModel) async {

    this.selectedChain = chainModel;
    List<Student_model> chainStudent =
        await FireStore_Helper.FireStoreHelper.getAllSpecifyStudentFromFirestore(selectedChain.chainName);
    notifyListeners();
    this.chainStudent=chainStudent;
    selectChainStudent(chainStudent.first);
    List<Hefth_Model> reportHistory =
    await FireStore_Helper.FireStoreHelper.getAllReportHistoryFromFirestore(this.selectedChainStudent.studentName);
    this.reportHistory = reportHistory;
    notifyListeners();
    selectReportHistory(reportHistory.first);
    notifyListeners();
  }

  Mohafeth_model selectedHelperMohafeth;
  selectHelperMohafeth(Mohafeth_model mohafethModel) {
    this.selectedHelperMohafeth = mohafethModel;
    notifyListeners();
  }
  Exam_model selectedHistory;
  selectHistory(Exam_model exam_model) {
    this.selectedHistory = exam_model;
    notifyListeners();
  }
  Exam_model selectedExam;
  List<Exam_model> studentHistory;
  selectExam(Exam_model exam) async{
    this.selectedExam = exam;
    List<Exam_model> studentHistory =
        await FireStore_Helper.FireStoreHelper.getAllStudentExamFromFirestore(this.selectedExam.studentName);
    this.studentHistory=studentHistory;
    selectHistory(studentHistory.first);
    notifyListeners();
  }
  Exam_model selectedExamHistory;
  selectExamHistory(Exam_model exam) {
    this.selectedExamHistory = exam;
    notifyListeners();
  }
  selectReportHistory(Hefth_Model hefth) {
    this.selectedReport = hefth;
    notifyListeners();
  }
  List<String> age;
  String selectedAge;
  selectAge(String age) {
    this.selectedAge = age;
    notifyListeners();
  }
  getAge() async {
    List<String> age =['الفئة العمرية','الابتدائي','الاعدادي','الثانوي','الجامعي'];
    this.age = age;
    age.forEach((element) {
      print(age);
    });
    selectAge(age.first);
    notifyListeners();

  }

  List<String> hefthStatus;
  String selectedHefthStatus;
  selectHefthStatus(String hefthStatus) {
    this.selectedHefthStatus = hefthStatus;
    notifyListeners();
  }
  getHefthStatus() async {
    List<String> hefthStatus =['حالة التثبيت','غير مثبت','مثبت'];
    this.hefthStatus = hefthStatus;
    hefthStatus.forEach((element) {
      print(hefthStatus);
    });
    selectHefthStatus(hefthStatus.first);
    notifyListeners();

  }

  selectStatus(String status) {
    this.selectedStatus = status;
    notifyListeners();
  }
  Chat_model selectedChat;
  selectMessage(Chat_model chat) {
    this.selectedChat = chat;
    notifyListeners();
  }
  getStatus() async {
    List<String> StatusList=["حالة الاسرة","فقيرة","متوسطة","غنية"];
    this.StatusList = StatusList;
    selectStatus(StatusList.first);
    notifyListeners();

  }
  nullArray(){
    this.studentReports=null;
    this.pageNumber=null;
    this.revisionPage=null;
    this.coming=null;
    this.assessment=null;
    notifyListeners();
  }
  selectCourse(String Course) {
    this.selectedCourse = Course;
    notifyListeners();
  }
  getCourse() async {
    List<String> CourseList=["دورات الاحكام","تمهيدية","تاهيلية","عليا","تاهيل سند","سند متصل"];
    this.CourseList = CourseList;
    selectCourse(CourseList.first);
    notifyListeners();

  }
  getChainFromFirestore() async {
    List<Chain_model> chains =
    await FireStore_Helper.FireStoreHelper.getAllChainFromFirestore();
    this.chains = chains;
    chains.forEach((element) { print(element.chainName);});
    selectChain(chains.first);
    notifyListeners();


  }
  List<Hefth_Model> daiyHefth;
  getDailyHefthFromFirestore() async {
    List<Hefth_Model> daiyHefth =
    await FireStore_Helper.FireStoreHelper.getDailyHefthDateFromFirestore((loginUser as Student_model).studentName, getDate());
    print((loginUser as Student_model).studentName+'//**//*/**/*/'+getDate());
    this.daiyHefth = daiyHefth;
    daiyHefth.forEach((element) { print(element.studentNameHefth);});
    notifyListeners();


  }
  List<Student_model> students;
  getStudentFromFirestore() async {
    List<Student_model> students =
    await FireStore_Helper.FireStoreHelper.getAllStudentFromFirestore();
    this.students = students;
    notifyListeners();

  }
  List<Hefth_Model> studentReports;
  double estimation;
  int pageNumber;
  int revisionPage;
  int coming;
  String assessment="";
  getStudentReportFromFirestore(name,minDate,maxDate) async {
    int pageNumber=0;
    int revisionPage=0;
    double excellent=0;
    double excellentLength=0;
    double veryGood=0;
    double veryGoodLength=0;
    double good=0;
    double goodLength=0;
    List<Hefth_Model> studentReports =
    await FireStore_Helper.FireStoreHelper.getAllReportDateFromFirestore(name,minDate,maxDate);
    this.studentReports = studentReports;
    this.studentReports.forEach((element) {
      pageNumber+=int.parse(element.pageNumber);
      revisionPage+=int.parse(element.revisionPage);
      if(int.parse(element.estimate)>=90){
        excellent+=int.parse(element.estimate);
        ++excellentLength;
      }else if(int.parse(element.estimate)>=80){
        veryGood+=int.parse(element.estimate);
        ++veryGoodLength;
      }else if(int.parse(element.estimate)>=70){
        good+=int.parse(element.estimate);
        ++goodLength;
      }

    });
    print(excellent);
    double excellantAverage=excellentLength==0?0:excellent/excellentLength;
    double veryGoodAverage=veryGoodLength==0?0:veryGood/veryGoodLength;
    double goodAverage=goodLength==0?0:good/goodLength;
    double estimation=(excellantAverage+veryGoodAverage+goodAverage)/3;
    if(estimation>=90){
      assessment="ممتاز";
    }else if(estimation>=80){
      assessment="جيد جدا";
    }else if(estimation>=70){
      assessment="جيد";
    }else{
      assessment="راسب";
    }
    int coming=this.studentReports.length;
    this.revisionPage=revisionPage;
    this.pageNumber=pageNumber;
    this.estimation=estimation;
    this.coming=coming;
    notifyListeners();

  }
  getHelperMohafethFromFirestore() async {
    List<Mohafeth_model> mohafeths =
    await FireStore_Helper.FireStoreHelper.getAllMohafethFromFirestore();
    this.helperMohafeths = mohafeths;
    selectHelperMohafeth(mohafeths.first);
    notifyListeners();

  }
  getMohafethChainFromFirestore() async {
    print((this.loginUser as Mohafeth_model).mohafethName);
    List<Chain_model> mohafethChain =
    await FireStore_Helper.FireStoreHelper.getSpecifyChainFromFirestore((this.loginUser as Mohafeth_model).mohafethName);
    this.mohafethChain = mohafethChain;
    mohafethChain.forEach((element) {print(element.chainName);});
    notifyListeners();

  }
  List<Hefth_Model> studentReportBegin;
  List<Hefth_Model> studentReportEnd=[
    Hefth_Model(
      date: "",
      studentNameHefth: "",
      revisionPage: "",
      pageNumber: "",
      estimate: "",
      endSora: "",
      endAya: "",
      beginSora: "",
      beginAya: "",
    )
  ];
  getStudentbeginReportFromFirestore() async {
    List<Hefth_Model> studentReportBegin =
    await FireStore_Helper.FireStoreHelper.getAllReportHistoryFromFirestore((this.loginUser as Student_model).studentName);
    this.studentReportBegin = studentReportBegin;
    studentReportBegin.forEach((element) {print(element.date);});
    selectStudentReportBegin(studentReportBegin.first);
    notifyListeners();

  }
  Hefth_Model selectedStudentReportBegin;
  selectStudentReportBegin(Hefth_Model hefth) async {
    this.selectedStudentReportBegin = hefth;
    notifyListeners();
    List<Hefth_Model> studentReportEnd =
    await FireStore_Helper.FireStoreHelper.getAllReportHistory2FromFirestore((this.loginUser as Student_model).studentName,selectedStudentReportBegin.date);
    this.studentReportEnd = studentReportEnd;
    // for(int i=studentReportBegin.indexOf(this.selectedStudentReportBegin);i<studentReportBegin.length;i++){
    //   studentReportEnd.add(studentReportBegin[i]);
    // }
    notifyListeners();
    selectStudentReportEnd(studentReportEnd.first);
    notifyListeners();

  }
  Hefth_Model selectedStudentReportEnd;
  selectStudentReportEnd(Hefth_Model hefth) async {
    this.selectedStudentReportEnd = hefth;
    notifyListeners();

  }
  List<Student_model> studentChain;
  getStudentChainFromFirestore() async {
    print(this.mohafethChain.first.chainName+'/-----');
    List<Student_model> studentChain =
    await FireStore_Helper.FireStoreHelper.getSpecifyStudentChainFromFirestore(this.mohafethChain.first.chainName);
    this.studentChain = studentChain;
    studentChain.forEach((element) {print(element.studentName);});
    selectStudentChain(studentChain.first);
    notifyListeners();

  }
  List<Student_model> studentChain1;
  String chain1;
  getStudentChainFromFirestore1() async {
    List<Student_model> studentChain1 =
    await FireStore_Helper.FireStoreHelper.getSpecifyStudentChainFromFirestore(this.chain1);
    this.studentChain1 = studentChain1;
    notifyListeners();

  }
  chainName(name){
    this.chain1=name;
    notifyListeners();

  }
  Student_model selectedStudentChain;
  selectStudentChain(Student_model student) async {
    this.selectedStudentChain = student;
    notifyListeners();
    List<Hefth_Model> reportHistory =
    await FireStore_Helper.FireStoreHelper.getAllReportHistoryFromFirestore(this.selectedStudentChain.studentName);
    this.reportHistory = reportHistory;
    notifyListeners();
    selectReportHistory(reportHistory.first);
    notifyListeners();

  }
  List<Exam_model> examChain;

  getExamFromFirestore() async {
    print(mohafethChain.first.chainName);
    List<Exam_model> examChain =
    await FireStore_Helper.FireStoreHelper.getSpecifyExamFromFirestore(mohafethChain.first.chainName);
    this.examChain = examChain;
    examChain.forEach((element) {print(element.examPerson+"///////"+element.examName);});

    notifyListeners();

  }
  List<Exam_model> allExamChain;

  getAllExamFromFirestore() async {
    List<Exam_model> allExamChain =
    await FireStore_Helper.FireStoreHelper.getSpecifyExamFromFirestore(mohafethChain.first.chainName);
    print(mohafethChain.first.chainName);
    this.allExamChain = allExamChain;
    allExamChain.forEach((element) {print(element.examPerson+"///////"+element.examName);});
    selectExam(allExamChain.first);
    notifyListeners();

  }
  List<Exam_model> examHistory;


  List<Exam_model> studentArcheive;

  getStudentArcheiveFromFirestore() async {
    List<Exam_model> studentArcheive =
    await FireStore_Helper.FireStoreHelper.getStudentExamArcheiveFromFirestore(this.selectedExam.studentName, this.selectedHistory.examDate);
    this.studentArcheive = studentArcheive;
    studentArcheive.forEach((element) {print(element.examPerson+"///////"+element.examName);});
    notifyListeners();

  }
  List<Exam_model> studentExams;
  getStudentExamsFromFirestore() async {
    List<Exam_model> studentExams =
    await FireStore_Helper.FireStoreHelper.getAllStudentExamFromFirestore((this.loginUser as Student_model).studentName);
    this.studentExams = studentExams;
    studentExams.forEach((element) {print(element.studentName+"///////"+element.examName);});
    notifyListeners();

  }
  List<Chain_model> chain;
  getSpecifyChainStudentFromFirestore() async {
    List<Chain_model> chain =
    await FireStore_Helper.FireStoreHelper.getSpecifyChainStudentFromFirestore((this.loginUser as Student_model).chainName);
    this.chain = chain;
    chain.forEach((element) {print(element.chainName+"///////"+element.chainMohafeth);});
    notifyListeners();

  }
  List<Hefth_Model> reports;
  Hefth_Model selectedHefth;
  selectReport(Hefth_Model hefth){
    this.selectedHefth=hefth;
    notifyListeners();
  }
  getSpecifyReportsFromFirestore() async {
    List<Hefth_Model> reports =
    await FireStore_Helper.FireStoreHelper.getAllReportFromFirestore((this.loginUser as Student_model).studentName);
    this.reports = reports;
    selectReport(reports.first);
    notifyListeners();
    reports.forEach((element) {print(element.studentNameHefth+"///////"+element.date);});

  }
  List<Hefth_Model> allReports;
  getAllReports()async{
    List<Hefth_Model> allReports =
        await FireStore_Helper.FireStoreHelper.getReportsFromFirestore();
    this.allReports = allReports;
    notifyListeners();
    allReports.forEach((element) {print(element.studentNameHefth+"///////"+element.date);});
  }
  List<Coming_model> mohafethComing;
  getmohafethComing()async{
    List<Coming_model> mohafethComing =
    await FireStore_Helper.FireStoreHelper.getComingDateFromFirestore();
    this.mohafethComing = mohafethComing;
    notifyListeners();
    mohafethComing.forEach((element) {print(element.name+"///////"+element.date);});
  }
  List<Hefth_Model> dailyHefth=[];
  List<Hefth_Model> reportsChain;

  List<Student_model> studentsMohafeth;
  getStudentChainReport()async{
    hefthCount=0;
    revisionCount=0;
    comingCount=0;
    notifyListeners();
    List<Hefth_Model> reportsChain=await FireStore_Helper.FireStoreHelper.getDailyHefthReportFromFirestore2(mohafethChain.first.chainName);
    this.reportsChain=reportsChain;

    this.reportsChain.forEach((element) {
      print(element.studentNameHefth+'**/---------*-/-/'+element.chainName);
      hefthCount+=int.parse(element.pageNumber);
      revisionCount+=int.parse(element.revisionPage);
    });
    comingCount=reportsChain.length;
    notifyListeners();

  }

  List<Chat_model> chats;
  int countChats;
  getAllChats()async{
    String type;
    if(loginUser.runtimeType==Moshref_model){
      type =(loginUser as Moshref_model).moshrefName;
    }else if(loginUser.runtimeType==Mohafeth_model){
      type =(loginUser as Mohafeth_model).mohafethName;
    }else if(loginUser.runtimeType==Student_model){
      type =(loginUser as Student_model).studentName;
    }
    List<Chat_model> chats =
    await FireStore_Helper.FireStoreHelper.getChatFromFirestore(type);
    this.chats = chats;
    countChats=chats.length;
    notifyListeners();
    chats.forEach((element) {print(element.receiver+"///////"+element.sender);});
  }

  getMohafethFromFirestore() async {
    List<Mohafeth_model> mohafeths =
    await FireStore_Helper.FireStoreHelper.getAllMohafethFromFirestore();
    this.mohafeths = mohafeths;
    selectMohafeth(mohafeths.first);
    notifyListeners();

  }
  List<Coming_model> comingList;
  getComingFromFirestore() async {
    List<Coming_model> comingList =
    await FireStore_Helper.FireStoreHelper.getComingFromFirestore();
    this.comingList = comingList;
    comingList.forEach((element) {
      print(element.date);
    });
    notifyListeners();

  }

  insertReport() async{
    DateTime date=DateTime.now();
    final DateFormat format = DateFormat('dd/MM/yyyy');
    final String formatted = format.format(date);
    print(formatted);
    Hefth_Model hefth=Hefth_Model(
      studentNameHefth: conName.text,
      beginAya:conBeginAya.text,
      beginSora:conBeginSora.text,
      endAya:conEndAya.text,
      endSora:conEndSora.text,
      pageNumber:conPageNumber.text,
      revisionPage:conRevisionPage.text,
      estimate:conEstimate.text,
      date:formatted,
      chainName:this.mohafethChain.first.chainName
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
        familyStatus:selectedStatus,
        password:PasswordCon.text,
        course:selectedCourse,
      );
      await FireStore_Helper.FireStoreHelper.add("mohafeths",mohafeth.toMap());
      await FireStore_Helper.FireStoreHelper.add("coming", {
        "name":mohafethNameCon.text,
        "status":"لم يسجل",
        "date":getDate(),
        "id":"",
        "color":"Colors.white"
      });
       getId("coming", mohafethNameCon.text,getDate());



    } on Exception catch (e) {
      // TODO
    }
// navigate to login


  }
  var documentID;
  getId(table , name,date)async{
    var documentID;
    var collection = FirebaseFirestore.instance.collection(table);
    var querySnapshots = await collection.get();
    for (var snapshot in querySnapshots.docs) {
      if(name==snapshot.data()['name']&&date==snapshot.data()['date']){
      documentID = snapshot.id;
      FireStore_Helper.FireStoreHelper.fireStore.collection("coming").doc(documentID).update(
          {
            "name":mohafethNameCon.text,
            "status":"لم يسجل",
            "date":getDate(),
            "id":documentID,
            "color":"Colors.white"
          });

      }
      // <-- Document ID
    }
  }
  var documentID2;
  getId2(table , name,date)async{
    var documentID2;
    var collection = FirebaseFirestore.instance.collection(table);
    var querySnapshots = await collection.get();
    for (var snapshot in querySnapshots.docs) {
      if(name==snapshot.data()['name']&&date==snapshot.data()['date']){
        documentID2 = snapshot.id;
        this.documentID2=documentID2;
        FireStore_Helper.FireStoreHelper.fireStore.collection("coming").doc(documentID2).update(
            {
              "name":name,
              "status":"لم يسجل",
              "date":getDate(),
              "id":documentID2,
              "color":"Colors.white"
            });

      }
      // <-- Document ID
    }
  }
  add(table,map) async{
    await FireStore_Helper.FireStoreHelper.add(table,map);

  }
  addMessage() async{
    String type;
    final df = new DateFormat('dd/MM/yyyy hh:mm a');
    if(loginUser.runtimeType==Moshref_model){
      type =(loginUser as Moshref_model).moshrefName;
    }else if(loginUser.runtimeType==Mohafeth_model){
      type =(loginUser as Mohafeth_model).mohafethName;
    }else if(loginUser.runtimeType==Student_model){
      type =(loginUser as Student_model).studentName;
    }
    await FireStore_Helper.FireStoreHelper.add("messages",
    {
      'text':conMessage.text,
      'sender':type,
      'receiver':selectedPerson,
      'date':df.format(DateTime.now()),
    }
    );

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
        chainName: selectedChain.chainName,
        familyStatus:selectedStatus,
        password:PasswordCon.text,
        address:studentAddressCon.text,
        course: selectedCourse,
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
      sheet.getRangeByName('F'+count.toString()).setText(element.familyStatus);
      sheet.getRangeByName('G'+count.toString()).setText(element.password);
      sheet.getRangeByName('H'+count.toString()).setText(element.course);
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
  Future<void> createExcelStudentChain() async
  {

    //Create a Excel document.
    //Creating a workbook.
    final Workbook workbook = Workbook();
    //Accessing via index.
    final Worksheet sheet = workbook.worksheets[0];
    // Set the text value.

    this.studentChain.forEach((element) {
      count=count+1;
      print(element.studentName);
      sheet.getRangeByName('A'+count.toString()).setText(element.studentName);
      sheet.getRangeByName('B'+count.toString()).setText(element.studentCard);
      sheet.getRangeByName('C'+count.toString()).setText(element.birthDate);
      sheet.getRangeByName('D'+count.toString()).setText(element.fatherIdCard);
      sheet.getRangeByName('E'+count.toString()).setText(element.mobile);
      sheet.getRangeByName('F'+count.toString()).setText(element.classRoom);
      sheet.getRangeByName('G'+count.toString()).setText(element.chainName);
      sheet.getRangeByName('H'+count.toString()).setText(element.familyStatus);
      sheet.getRangeByName('I'+count.toString()).setText(element.password);
      sheet.getRangeByName('J'+count.toString()).setText(element.address);
      sheet.getRangeByName('K'+count.toString()).setText(element.fatherWork);
      sheet.getRangeByName('L'+count.toString()).setText(element.course);
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
  Future<void> createExamChain() async
  {

    //Create a Excel document.
    //Creating a workbook.
    final Workbook workbook = Workbook();
    //Accessing via index.
    final Worksheet sheet = workbook.worksheets[0];
    // Set the text value.

    this.examChain.forEach((element) {
      count=count+1;
      print(element.studentName);
      sheet.getRangeByName('A'+count.toString()).setText(element.studentName);
      sheet.getRangeByName('B'+count.toString()).setText(element.chainName);
      sheet.getRangeByName('C'+count.toString()).setText(element.examName);
      sheet.getRangeByName('D'+count.toString()).setText(element.examDate);
      sheet.getRangeByName('E'+count.toString()).setText(element.grade);
      sheet.getRangeByName('F'+count.toString()).setText(element.estimation);
      sheet.getRangeByName('G'+count.toString()).setText(element.examPerson);

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
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await FirebaseFirestore.instance.collection('exams').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<Exam_model> exam =
    docs.map((e) => Exam_model.fromMap(e.data())).toList();
    exam.forEach((element) {
      count=count+1;
      sheet.getRangeByName('A'+count.toString()).setText(element.chainName);
      sheet.getRangeByName('B'+count.toString()).setText(element.studentName);
      sheet.getRangeByName('C'+count.toString()).setText(element.examName);
      sheet.getRangeByName('D'+count.toString()).setText(element.grade);
      sheet.getRangeByName('E'+count.toString()).setText(element.estimation);
      sheet.getRangeByName('F'+count.toString()).setText(element.examDate);
      sheet.getRangeByName('G'+count.toString()).setText(element.examPerson);
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
  Future<void> createExcelComing() async
  {
    //Create a Excel document.
    //Creating a workbook.
    final Workbook workbook = Workbook();
    //Accessing via index.
    final Worksheet sheet = workbook.worksheets[0];
    // Set the text value.
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await FirebaseFirestore.instance.collection('coming').orderBy('date',descending: false).get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<Coming_model> exam =
    docs.map((e) => Coming_model.fromMap(e.data())).toList();
    exam.forEach((element) {
      count=count+1;
      sheet.getRangeByName('A'+count.toString()).setText(element.name);
      sheet.getRangeByName('B'+count.toString()).setText(element.status);
      sheet.getRangeByName('C'+count.toString()).setText(element.date);
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

  Uint8List imageUi;
  String pdfType="";
  selectPdfType(String type){
    this.pdfType=type;
    notifyListeners();
  }
  Future<void> createPDF() async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();

print(page.getClientSize().height);
    ///page.graphics.rotateTransform(45);
    page.graphics.drawImage(
        PdfBitmap(imageUi),
        Rect.fromLTWH(0, 0, page.getClientSize().width, this.pdfType=="report"?page.getClientSize().height:page.getClientSize().height-331));



    List<int> bytes = document.save();
    document.dispose();
    if (kIsWeb) {
      saveAndLaunchFileWeb(bytes, 'Output.pdf');
    }else{
      saveAndLaunchFileMobile(bytes, 'Output.pdf');
    }

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
