import 'package:flutter/material.dart';

import '../../main.dart';
class DataPlaceFather extends StatelessWidget {
  String txt;
  String data;
  Function function;
  TextEditingController controller=TextEditingController();
  bool enable;
  bool read;
  DataPlaceFather(this.txt, this.controller,this.data,this.read,this.enable,this.function);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
      child: Row(
        children: [
          Expanded(flex:3,child: Text(txt,style: TextStyle(fontSize: 18,color: Colors.black),)),
          SizedBox(width: 10,),
          Expanded(
            flex: 3,
            child: Container(
              decoration: new BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 10.0,
                  ),
                ],
                shape: BoxShape.rectangle,
              ),
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.center,
                readOnly: read,
                controller: controller,
                style: TextStyle(color: mainColor,fontSize: 18),
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
                    border: OutlineInputBorder(
                    ),
                    filled: true,
                    enabled: enable,
                    hintText: data,
                    hintStyle:TextStyle(fontSize: 18,color:mainColor) ,
                    fillColor: Colors.white70),
              ),
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                children: [
                  IconButton(
                    onPressed: function,
                    icon: Icon(Icons.phone),
                    iconSize: 20,
                    color: Colors.white,
                  ),
                ],
              ),
              width:20,
              height: 50,
              decoration: BoxDecoration(
                  color:mainColor,
                  borderRadius: BorderRadius.all(Radius.circular(50))
              ),
            ),)
        ],
      ),
    );
  }
}
