import 'package:flutter/material.dart';

class InputModel extends StatelessWidget {
  TextEditingController c;
  String hint;
  IconData icon;
  VoidCallback? ontap;
  InputModel({Key? key,required  this.c, required  this.hint,required  this.icon,this.ontap}) : super(key: key);

  Widget Field(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        minLines: 1,
        maxLines: 20,
        onTap: ontap,
        readOnly: ontap!=null,
        controller: c,
        decoration: InputDecoration(
            hintText: hint,
            suffixIcon:Icon(icon),
            labelText: hint,
            labelStyle: TextStyle(color: Colors.black),
            border: b(false),
            focusedErrorBorder: b(true),
            errorBorder: b(true),
            focusedBorder: b(false)
        ),
      ),
    );
  }

  InputBorder b(bool error){
    return error?OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red,width: 1)
    ):OutlineInputBorder(
        borderSide: BorderSide(color: Colors.orangeAccent,width: 1)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Field();
  }
}
