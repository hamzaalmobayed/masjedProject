import 'package:flutter/material.dart';
import 'package:masjed/main.dart';
class HistoryButton extends StatelessWidget {
  String name;
  double width;
  Color textColor;
  Color backGroundColor;
  Function function;
  Function function2;
  HistoryButton(this.name,this.width,this.textColor,this.backGroundColor,this.function,this.function2);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
          width: width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.fromBorderSide(BorderSide(color: mainColor,width: 2)),
            color: backGroundColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 10.0,
              ),
            ],
          ),
          child:InkWell(onTap:function,child: Text(name,style: TextStyle(fontSize: 14,color: textColor),),onLongPress: function2,)
      ),
    );
  }
}
