import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:masjed/model/ChainModel.dart';
import 'package:masjed/model/ChatModel.dart';
import 'package:masjed/model/ComingModel.dart';
import 'package:masjed/model/ExamModel.dart';
import 'package:masjed/model/HefthModel.dart';
import 'package:masjed/model/MohafethModel.dart';
import 'package:masjed/model/MoshrefModel.dart';
import 'package:masjed/model/StudentModel.dart';
import 'package:masjed/provider.dart';

class FireStore_Helper {
  FireStore_Helper._();

  static FireStore_Helper FireStoreHelper = FireStore_Helper._();
  FirebaseFirestore fireStore = FirebaseFirestore.instance;



  Future<List<Mohafeth_model>> getAllMohafethFromFirestore() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await fireStore.collection('mohafeths').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<Mohafeth_model> users =
    docs.map((e) => Mohafeth_model.fromMap(e.data())).toList();
    print(users.length);
    return users;
  }
  Future<List<Student_model>> getAllStudentFromFirestore() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await fireStore.collection('students').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<Student_model> users =
    docs.map((e) => Student_model.fromMap(e.data())).toList();
    print(users.length);
    return users;
  }
  Future<List<Student_model>> getAllSpecifyStudentFromFirestore(String chain) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await fireStore.collection('students').where('chainName',isEqualTo: chain).get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<Student_model> users =
    docs.map((e) => Student_model.fromMap(e.data())).toList();
    print(users.length);
    return users;
  }
  Future<List<Chain_model>> getAllChainFromFirestore() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await fireStore.collection('chains').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<Chain_model> users =
    docs.map((e) => Chain_model.fromMap(e.data())).toList();
    print(users.length);
    return users;
  }
  Future<List<Chain_model>> getSpecifyChainFromFirestore(String name) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await fireStore.collection('chains').where('chainMohafeth',isEqualTo: name).get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<Chain_model> users =
    docs.map((e) => Chain_model.fromMap(e.data())).toList();
    print(users.length);
    return users;
  }
  Future<List<Chain_model>> getSpecifyChainStudentFromFirestore(String name) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await fireStore.collection('chains').where('chainName',isEqualTo: name).get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<Chain_model> users =
    docs.map((e) => Chain_model.fromMap(e.data())).toList();
    print(users.length);
    return users;
  }
  Future<List<Student_model>> getSpecifyStudentChainFromFirestore(String name) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await fireStore.collection('students').where("chainName",isEqualTo: name).get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<Student_model> users =
    docs.map((e) => Student_model.fromMap(e.data())).toList();
    print(users.length);
    return users;
  }
  Future<List<Exam_model>> getSpecifyExamFromFirestore(String name) async {
    print(name);
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await fireStore.collection('exams').where('chainName',isEqualTo: name).get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<Exam_model> users =
    docs.map((e) => Exam_model.fromMap(e.data())).toList();

    return users;
  }
  Future<List<Exam_model>> getStudentExamHistoryFromFirestore(String name) async {
    print(name);
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await fireStore.collection('exams').where('studentName',isEqualTo: name,).get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<Exam_model> users =
    docs.map((e) => Exam_model.fromMap(e.data())).toList();
    print(users.length);

    return users;
  }
  Future<List<Exam_model>> getStudentExamArcheiveFromFirestore(String name,String date) async {
    print(name);
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await fireStore.collection('exams').where('studentName',isEqualTo: name,).where('examDate',isEqualTo: date).get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<Exam_model> users =
    docs.map((e) => Exam_model.fromMap(e.data())).toList();
    print(users.length);

    print(users.first.examName);
    return users;
  }

  Future<List<Exam_model>> getAllStudentExamFromFirestore(String name) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await fireStore.collection('exams').where('studentName',isEqualTo: name).get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<Exam_model> users =
    docs.map((e) => Exam_model.fromMap(e.data())).toList();
    print(users.length);

    print(users.first.examName);
    return users;
  }
  Future<List<Hefth_Model>> getAllReportFromFirestore(String name) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await fireStore.collection('reports').where('studentNameHefth',isEqualTo: name).orderBy('date',descending: false).get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<Hefth_Model> users =
    docs.map((e) => Hefth_Model.fromMap(e.data())).toList();
    print(users.length);
    return users;
    print(users.first.studentNameHefth+"///"+users.first.revisionPage);
  }
  Future<List<Hefth_Model>> getReportsFromFirestore() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await fireStore.collection('reports').where('date',isEqualTo: DateFormat('dd/MM/yyyy').format(DateTime.now())).get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<Hefth_Model> users =
    docs.map((e) => Hefth_Model.fromMap(e.data())).toList();
    print(users.first.date);
    return users;
    print(users.first.studentNameHefth+"///"+users.first.revisionPage);
  }
  Future<List<Coming_model>> getComingDateFromFirestore() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await fireStore.collection('coming').where('date',isEqualTo: DateFormat('dd/MM/yyyy').format(DateTime.now())).where('status',isEqualTo: 'حاضر').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<Coming_model> users =
    docs.map((e) => Coming_model.fromMap(e.data())).toList();
    print(users.first.date+'-**-*-*-*-*-'+users.length.toString());
    return users;
  }
  Future<List<Hefth_Model>> getAllReportDateFromFirestore(String name,minDate,maxDate) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await fireStore.collection('reports').orderBy('date',descending: false).where('studentNameHefth',isEqualTo: name,).where('date',isGreaterThanOrEqualTo: minDate).where('date',isLessThanOrEqualTo: maxDate).get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<Hefth_Model> users =
    docs.map((e) => Hefth_Model.fromMap(e.data())).toList();
    print(users.first.date);
    return users;
    print(users.first.studentNameHefth+"///"+users.first.revisionPage);
  }
  Future<List<Hefth_Model>> getDailyHefthDateFromFirestore(String name,Date) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await fireStore.collection('reports').where('studentNameHefth',isEqualTo: name,).where('date',isEqualTo: Date).get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<Hefth_Model> users =
    docs.map((e) => Hefth_Model.fromMap(e.data())).toList();
    print(users.first.studentNameHefth);
    return users;
    print(users.first.studentNameHefth+"///"+users.first.revisionPage);
  }
  Future<List<Hefth_Model>> getDailyHefthReportFromFirestore() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await fireStore.collection('reports').where('date',isEqualTo: DateFormat('dd/MM/yyyy').format(DateTime.now())).get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<Hefth_Model> users =
    docs.map((e) => Hefth_Model.fromMap(e.data())).toList();
    print(users.first.studentNameHefth);
    return users;
    print(users.first.studentNameHefth+"///"+users.first.revisionPage);
  }
  Future<List<Hefth_Model>> getDailyHefthReportFromFirestore2(chain) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await fireStore.collection('reports').orderBy("pageNumber",descending: false).where('date',isEqualTo: DateFormat('dd/MM/yyyy').format(DateTime.now())).where('chainName',isEqualTo: chain).get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<Hefth_Model> users =
    docs.map((e) => Hefth_Model.fromMap(e.data())).toList();
    print(users.first.studentNameHefth);
    return users;
    print(users.first.studentNameHefth+"///"+users.first.revisionPage);
  }
  Future<List<Hefth_Model>> getDailyHefthDateOrderFromFirestore(String name,Date) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await fireStore.collection('reports').where('studentNameHefth',isEqualTo: name,).where('date',isEqualTo: Date).orderBy('pageNumber',descending: false).get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<Hefth_Model> users =
    docs.map((e) => Hefth_Model.fromMap(e.data())).toList();
    print(users.first.studentNameHefth);
    return users;
    print(users.first.studentNameHefth+"///"+users.first.revisionPage);
  }
  Future<List<Hefth_Model>> getAllReportHistoryFromFirestore(String name) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await fireStore.collection('reports').orderBy('date',descending: false).where('studentNameHefth',isEqualTo: name,).get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<Hefth_Model> users =
    docs.map((e) => Hefth_Model.fromMap(e.data())).toList();
    print(name+'*/**/**');
    return users;
    print(users.first.studentNameHefth+"///"+users.first.revisionPage);
  }
  Future<List<Hefth_Model>> getAllReportHistory2FromFirestore(String name,minDate) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await fireStore.collection('reports').orderBy('date',descending: false).where('studentNameHefth',isEqualTo: name,).where('date',isGreaterThanOrEqualTo: minDate).get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<Hefth_Model> users =
    docs.map((e) => Hefth_Model.fromMap(e.data())).toList();
    print(users.first.date);
    return users;
    print(users.first.studentNameHefth+"///"+users.first.revisionPage);
  }
  Future<List<Moshref_model>> getMoshrefFromFirestore() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await fireStore.collection('moshref').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<Moshref_model> users =
    docs.map((e) => Moshref_model.fromMap(e.data())).toList();
    print(users.length);
    return users;
  }
  Future<List<Chat_model>> getChatFromFirestore(name) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await fireStore.collection('messages').where('receiver',isEqualTo: name).get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<Chat_model> users =
    docs.map((e) => Chat_model.fromMap(e.data())).toList();
    print(users.length);
    return users;
  }
  Future<List<Coming_model>> getComingFromFirestore() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await fireStore.collection('coming').orderBy('date',descending: false).get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<Coming_model> users =
    docs.map((e) => Coming_model.fromMap(e.data())).toList();
    print(users.length);
    return users;
  }
  Future<void> add(String table, map) {
    // Call the user's CollectionReference to add a new user
    return fireStore
        .collection(table)
        .add(map)
        .then((value) => print(" Added"))
        .catchError((error) => print("Failed to add : $error"));
  }

  Future<void> update(id, map, collection) {
    return fireStore
        .collection(collection)
        .doc(id)
        .update(map)
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> delete( collection) {
    return fireStore
        .collection(collection)
        .doc()
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }
  getUserFromFirestore(String userId,table) async {
    DocumentSnapshot documentSnapshot =
    await fireStore.collection(table).doc(userId).get();

    print(documentSnapshot.data());
  }



}
