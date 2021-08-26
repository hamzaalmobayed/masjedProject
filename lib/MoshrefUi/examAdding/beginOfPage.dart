import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:masjed/MoshrefUi/examAdding/testName.dart';
import 'package:masjed/firebase/storage.dart';
import 'package:masjed/model/ChainModel.dart';
import 'package:masjed/model/StudentModel.dart';
import 'package:masjed/provider.dart';
import 'package:provider/provider.dart';
class BeginOfPage extends StatelessWidget {
  var icon;

  BeginOfPage(this.icon);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderMasjed>(
      builder:(context,ProviderMasjed,x)=> Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [icon],
          ),
          Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0,right: 10,),
                  child: Text("اسم الحلقة",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black),),
                ),
              ],
            ),
            Container(
              width: 500,
              decoration: new BoxDecoration(
                color: Colors.white12,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[350],
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 10.0,
                  ),
                ],
                shape: BoxShape.rectangle,
              ),
              child:Container(
                width: 500,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[350],
                  border: Border.fromBorderSide(BorderSide(width: 1,)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[350],
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 10.0,
                    ),
                  ],),
                child: DropdownButton<Chain_model>(

                  isExpanded: true,
                  underline: SizedBox(),
                  icon: Icon(Icons.keyboard_arrow_down_sharp,color: Colors.black,),
                  iconSize: 30,
                  items: ProviderMasjed.chains.map(( value) {
                    return DropdownMenuItem<Chain_model>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 100),
                        child: new Text(value.chainName),
                      ),
                    );
                  }).toList(),
                  onChanged: (v) {
                    ProviderMasjed.selectChain(v);
                  },
                  value: ProviderMasjed.selectedChain,
                ),
              ),
            )
          ],
        ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0,right: 10,),
                    child: Text("اسم الطالب",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black),),
                  ),
                ],
              ),
              Container(
                width: 500,
                decoration: new BoxDecoration(
                  color: Colors.white12,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[350],
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 10.0,
                    ),
                  ],
                  shape: BoxShape.rectangle,
                ),
                child:Container(
                  width: 500,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[350],
                    border: Border.fromBorderSide(BorderSide(width: 1,)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[350],
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 10.0,
                      ),
                    ],),
                  child: DropdownButton<Student_model>(

                    isExpanded: true,
                    underline: SizedBox(),
                    icon: Icon(Icons.keyboard_arrow_down_sharp,color: Colors.black,),
                    iconSize: 30,
                    items: ProviderMasjed.chainStudent.map(( value) {
                      return DropdownMenuItem<Student_model>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 100),
                          child: new Text(value.studentName),
                        ),
                      );
                    }).toList(),
                    onChanged: (v) {
                      ProviderMasjed.selectChainStudent(v);
                    },
                    value: ProviderMasjed.selectedChainStudent,
                  ),
                ),
              )
            ],
          ),



        ],
      ),
    );
  }
}
