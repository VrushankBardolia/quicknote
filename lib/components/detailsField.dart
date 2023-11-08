import 'package:flutter/material.dart';

class DetailsField extends StatelessWidget {
  final TextEditingController controller;
  const DetailsField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value){
        if(value==null){
          return "Please Enter Details";
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
        hintText: 'Details',
        hintStyle: const TextStyle(fontSize: 18),
      ),
      style: const TextStyle(fontSize: 18),
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.multiline,
      maxLines: null,
    );
  }
}
