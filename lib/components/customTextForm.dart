import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String hint;
  final TextEditingController myController;
  final String? Function(String?) valid;
  final bool isNumber = false;
  final TextInputType? textInputType = TextInputType.text;
  CustomTextForm(
      {Key? key,
      required this.hint,
      required this.myController,
      required this.valid,
      TextInputType? textInputType})
      : super(key: key) {
    this.textInputType != textInputType;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        validator: valid,
        keyboardType: textInputType ?? TextInputType.text,
        controller: myController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          hintText: hint,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}
