import 'package:flutter/material.dart';
import 'package:masjed/MohafethUi/Mohafeth/mohafeth.dart';
import 'package:masjed/StudentUi/student/student.dart';
import 'package:masjed/bottomBar.dart';
import 'package:masjed/MoshrefUi/login/textField.dart';
import 'package:masjed/MoshrefUi/moshref/Moshref.dart';
import 'package:masjed/fatherUI/father.dart';
import 'package:masjed/model/MohafethModel.dart';
import 'package:masjed/model/MoshrefModel.dart';
import 'package:masjed/model/StudentModel.dart';
import 'package:masjed/provider.dart';
import 'package:masjed/sharedPreferences.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../launch.dart';
import '../../main.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

BuildContext loginCon;

class _LoginState extends State<Login> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<ProviderMasjed>(context,listen: false).getPersons();
  }
  @override
  Widget build(BuildContext context) {
    loginCon = context;
    return Consumer<ProviderMasjed>(
      builder: (context, ProviderMasjed, x) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: ListView(
            children: [
              GestureDetector(
                  child: Hero(
                      tag: "imageTag",
                      child: Image(
                        image: AssetImage("images/logo.png"),
                        height: 300,
                        width: 300,
                      ))),
              Center(
                  child: Text(
                "تسجيل دخول",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              )),
              TextFieldShape(
                  "اسم المستخدم",
                  ProviderMasjed.conLoginCard,
                  Icon(
                    Icons.person,
                    color: Colors.grey,
                    size: 30,
                  ),
                  TextInputType.emailAddress,
                  false),
              TextFieldShape(
                  "كلمة السر",
                  ProviderMasjed.conLoginPassword,
                  Icon(
                    Icons.lock,
                    color: Colors.grey,
                    size: 30,
                  ),
                  TextInputType.visiblePassword,
                  true),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 80),
                child: ElevatedButton(
                  onPressed: () {
                    ProviderMasjed.persons.clear();
                    ProviderMasjed.getLoginUser();
                    ProviderMasjed.getChainFromFirestore();
                    ProviderMasjed.getMohafethFromFirestore();
                    ProviderMasjed.getStudentFromFirestore();
                    ProviderMasjed.getComingFromFirestore();
                    ProviderMasjed.getAllReports();
                    ProviderMasjed.getmohafethComing();
                    ProviderMasjed.getDailyHefthFromFirestore();
                    ProviderMasjed.getStudentChainFromFirestore();
                    ProviderMasjed.getStudentChainReport();
                    print("type");
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.white.withOpacity(0),
                            insetPadding: EdgeInsets.zero,
                            contentPadding: EdgeInsets.zero,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            content:Builder(
                              builder: (context) {
                                // Get available height and width of the build area of this widget. Make a choice depending on the size.
                                var height = MediaQuery.of(context).size.height;
                                var width = MediaQuery.of(context).size.width;

                                return Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.zero,
                                    color:Colors.white.withOpacity(0) ,
                                    height:height,
                                    width: width,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 5,
                                      color: mainColor,
                                    ));
                              },
                            ),

                          );
                        });
                    Future.delayed(Duration(seconds: 2)).then((value) {
                      ProviderMasjed.getAllChats();
                      ProviderMasjed.hefthCount=0;

                    });
                    Future.delayed(Duration(seconds: 5)).then((value) {
                      ProviderMasjed.getAllChats();
                      if (ProviderMasjed.loginUser == null) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor:mainColor,
                                actions: [
                                  TextButton(onPressed: (){
                                    ProviderMasjed.conLoginCard.clear();
                                    ProviderMasjed.conLoginPassword.clear();
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (con)=>Login()));
                                  }, child: Text("المحاولة مرة اخرى",style: TextStyle(color: Colors.white,fontSize: 16),))
                                ],
                                content:Container(
                                  height: 80,
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.zero,
                                    child: Text("رقم الهوية او كلمة السر خاطئ و الرجاء المحاولة مرة اخرى",style: TextStyle(color: Colors.white,fontSize: 18),))

                              );
                            });
                      } else if (ProviderMasjed.loginUser.runtimeType ==
                          Moshref_model) {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (con) => Moshref()));
                      } else if (ProviderMasjed.loginUser.runtimeType ==
                          Mohafeth_model) {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (con) => Mohafeth()));
                      } else if (ProviderMasjed.loginUser.runtimeType ==
                          Student_model) {
                        Student_model s=ProviderMasjed.loginUser;
                        if(ProviderMasjed.cardType=="student"){
                          if(ProviderMasjed.getAgeOfStudent(s)>=10){
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (con) => Student()));
                          }else{
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      backgroundColor:mainColor,
                                      actions: [
                                        TextButton(onPressed: (){
                                          ProviderMasjed.conLoginCard.clear();
                                          ProviderMasjed.conLoginPassword.clear();
                                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (con)=>Login()));
                                        }, child: Text("المحاولة مرة اخرى",style: TextStyle(color: Colors.white,fontSize: 16),))
                                      ],
                                      content:Container(
                                          height: 100,
                                          width: double.infinity,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.zero,
                                          child: Text("عزيزي الطالب عمرك ما زال صغيرا فقط والدك مسموح له الدخول برقم الهوية!",style: TextStyle(color: Colors.white,fontSize: 18),))

                                  );
                                });
                          }
                        }else if(ProviderMasjed.cardType=="father"){
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (con) => Father()));
                        }
                      }
                    });
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(mainColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "دخول",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "عن المركز",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ),
                  Icon(
                    Icons.info,
                    color: Colors.black,
                    size: 30,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "تواصل معنا",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      UrlLauncher.urlLuncher.openFacebook();
                    },
                    icon: Icon(
                      Icons.facebook_rounded,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      UrlLauncher.urlLuncher.sendPhone();
                    },
                    icon: Icon(
                      Icons.ad_units,
                      color: Colors.black,
                      size: 30,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomBar(),
      ),
    );
  }
}
