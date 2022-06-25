import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:masjed/MohafethUi/Mohafeth/mohafeth.dart';
import 'package:masjed/MoshrefUi/moshref/Moshref.dart';
import 'package:masjed/StudentUi/student/student.dart';
import 'package:masjed/bottomBar.dart';
import 'package:masjed/fatherUI/father.dart';
import 'package:masjed/model/MohafethModel.dart';
import 'package:masjed/model/MoshrefModel.dart';
import 'package:masjed/model/StudentModel.dart';
import 'package:masjed/provider.dart';
import 'package:masjed/sharedPreferences.dart';
import 'package:provider/provider.dart';

import 'MoshrefUi/login/loginScreen.dart';
import 'helpers/dbHelper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Helper.x.initSharedPreference();
  await DbHelper.dbHelper.initDataBase();
  runApp(ChangeNotifierProvider<ProviderMasjed>(
    create: (context)=>ProviderMasjed(),
      child: MyApp()
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: child,
          );
        },
        theme: ThemeData(
          fontFamily: "Cairo",

        ),
        home: FutureBuilder(
          // Initialize FlutterFire:
          future: _initialization,
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              return Center(child:Text("error"));
            }

            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              return Splash();
            }

            // Otherwise, show something whilst waiting for initialization to complete
            return CircularProgressIndicator();
          },
        )
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

Color mainColor =Color.fromRGBO(0, 94,0,1);

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    Timer(
        Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) {
              print("222");
              print(Helper.x.getType());
              print("///////////");
              print(Helper.x.form);
              Widget screen;
              if(Helper.x.getType()==null){
                screen= Login();
              }else if(Helper.x.getType()=="Moshref_model"){
                Helper.x.getUser("login");
                Provider.of<ProviderMasjed>(context,listen: false).loginUser=Helper.x.form;
                screen=Moshref();
              }else if(Helper.x.getType()=="Mohafeth_model"){
                Helper.x.getUser("login");
                Provider.of<ProviderMasjed>(context,listen: false).loginUser=Helper.x.form;
                screen=Mohafeth();
              }else if(Helper.x.getType()=="Student_model"){
                Helper.x.getUser("login");
                Provider.of<ProviderMasjed>(context,listen: false).loginUser=Helper.x.form;
                String type=Helper.x.getStudentType();
                if(type=="student"){
                  screen=Student();
                }else if(type=="father"){
                  screen=Father();
                }
              }

              return screen;

            })));
    Provider.of<ProviderMasjed>(context,listen: false).getAllChats();
    Provider.of<ProviderMasjed>(context,listen: false).getPersons();
    Provider.of<ProviderMasjed>(context,listen: false).getLoginUser();
    Provider.of<ProviderMasjed>(context,listen: false).getChainFromFirestore();
    Provider.of<ProviderMasjed>(context,listen: false).getMohafethFromFirestore();
    Provider.of<ProviderMasjed>(context,listen: false).getStudentFromFirestore();
    Provider.of<ProviderMasjed>(context,listen: false).getComingFromFirestore();
    Provider.of<ProviderMasjed>(context,listen: false).getAllReports();
    Provider.of<ProviderMasjed>(context,listen: false).getmohafethComing();
    Provider.of<ProviderMasjed>(context,listen: false).getDailyHefthFromFirestore();
    Provider.of<ProviderMasjed>(context,listen: false).getStudentChainFromFirestore();
    Provider.of<ProviderMasjed>(context,listen: false).getStudentChainReport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
            child: Hero(
                tag: "imageTag",
                child: Image(
                    image: AssetImage("images/logo.png")
                  ,height: 500,
                  width: 500,
                )
            )),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
