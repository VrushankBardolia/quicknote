import 'package:flutter/material.dart';

class TitleField extends StatelessWidget {
  final TextEditingController controller;
  final bool focus;
  const TitleField({super.key, required this.controller, required this.focus});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value){
        if(value==null){
          return "Please Enter Title";
        }else{
          return null;
        }
      },
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.transparent)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.transparent)
        ),
        hintText: 'Title',
        hintStyle: const TextStyle(fontSize: 22,fontWeight: FontWeight.w600),
      ),
      style: const TextStyle(fontSize: 22,fontWeight: FontWeight.w600),
      textCapitalization: TextCapitalization.words,
      autofocus: focus,
    );
  }
}
