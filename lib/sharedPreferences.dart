import 'dart:convert';
import 'package:masjed/model/MohafethModel.dart';
import 'package:masjed/model/MoshrefModel.dart';
import 'package:masjed/model/StudentModel.dart';
import 'package:masjed/provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Helper{
  Helper._();
  static Helper x =Helper._();
  SharedPreferences sharedPreferences;
  String typeUser;
  dynamic form;
  initSharedPreference()async{
    sharedPreferences= await SharedPreferences.getInstance();
  }
  saveStudentType(String name){
    sharedPreferences.setString('type', name);
  }
  String getStudentType(){
    return sharedPreferences.getString('type');
  }
  saveType(){
    sharedPreferences.setString('typeUser', typeUser);
  }
  String getType(){
    return sharedPreferences.getString('typeUser');
  }
  saveUser(String key,  value) async {
    if (value.runtimeType ==Moshref_model) {
      Moshref_model type=value;
      typeUser="Moshref_model";
      sharedPreferences.setString(key, json.encode({...type.toMap()}));
    }else if (value.runtimeType ==Mohafeth_model) {
      Mohafeth_model type=value;
      typeUser="Mohafeth_model";
      sharedPreferences.setString(key, json.encode({...type.toMap()}));
    }else if (value.runtimeType ==Student_model) {
      Student_model type=value;
      typeUser="Student_model";
      sharedPreferences.setString(key, json.encode({...type.toMap()}));
    }
    saveType();

    print("saving done");

  }
   getUser(String key) async {
     String user = sharedPreferences.getString('login');
     if(user==null){
       return null;
     }
     Map usermap= json.decode(user);

     if (getType() =="Moshref_model") {
       Moshref_model formu = Moshref_model.fromMap(usermap);
       form=formu;
     }else if (getType()=="Mohafeth_model") {
       Mohafeth_model formu = Mohafeth_model.fromMap(usermap);
       form=formu;
     }else if (getType()=="Student_model") {
       Student_model formu = Student_model.fromMap(usermap);
       form=formu;
     }

     return form;
  }

  Signout(String key){
    sharedPreferences.remove(key);
  }

}