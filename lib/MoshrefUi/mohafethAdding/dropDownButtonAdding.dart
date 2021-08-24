import 'package:flutter/material.dart';
import 'package:masjed/main.dart';
import 'package:masjed/provider.dart';
import 'package:provider/provider.dart';
class DropDownButtonAdding extends StatefulWidget {
String value;
List<dynamic> item;

DropDownButtonAdding(this.value, this.item);

  @override
  _DropDownButtonAddingState createState() => _DropDownButtonAddingState();
}

class _DropDownButtonAddingState extends State<DropDownButtonAdding> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderMasjed>(
      builder:(context,ProviderMasjed,x)=> Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: DropdownButton<dynamic>(
          value:widget.value,
          icon: Icon(Icons.keyboard_arrow_down_sharp),

          iconSize: 30,
          elevation: 16,
          isExpanded: true,
          style: TextStyle(color: Colors.grey, fontSize: 17.0,fontFamily:"Cairo",),
          underline: Container(
            height: 2,
            color: mainColor,
          ),
          onChanged: (newValue) {
             ProviderMasjed.selectMohafeth(newValue);

          },
          items:
          widget.item.map<DropdownMenuItem<dynamic>>((value) {
            return DropdownMenuItem<dynamic>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
