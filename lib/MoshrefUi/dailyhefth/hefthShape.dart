import 'package:flutter/material.dart';
import 'package:masjed/MoshrefUi/history/historyButton.dart';
class HefthShape extends StatelessWidget {
  String txt1;
  String txt2;
  Color textColor;
  Color backGroundColor;
  Function function1;
  Function function2;
  Function function3;

  HefthShape(
      this.txt1, this.txt2, this.textColor, this.backGroundColor,this.function1,this.function2,this.function3);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,),
      child: Row(
        children: [
          Expanded(flex:1,child: HistoryButton(txt1, 10,textColor,backGroundColor,function1,function3),),
          SizedBox(width: 20,),
          Expanded(flex:5,child: HistoryButton(txt2, 100,textColor,backGroundColor,function2,function3),),
        ],
      ),
    );
  }
}
