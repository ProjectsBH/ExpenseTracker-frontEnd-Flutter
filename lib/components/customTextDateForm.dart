import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class customTextDateForm extends StatefulWidget {
  final String hint;
  final TextEditingController myController;
  final String? Function(String?) valid;
  final bool isNumber = false;
  const customTextDateForm(
      {Key? key,
      required this.hint,
      required this.myController,
      required this.valid})
      : super(key: key);
  @override
  State<customTextDateForm> createState() => _customTextDateFormState();
}

class _customTextDateFormState extends State<customTextDateForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        validator: widget.valid,
        controller: widget.myController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          hintText: widget.hint,
          prefixIcon: InkWell(
            onTap: () {
              _selectedTransDate(context, widget.myController);
            },
            child: Icon(Icons.calendar_today),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }

  DateTime _dateTime = DateTime.now();
  _selectedTransDate(
      BuildContext context, TextEditingController myController) async {
    var _pickedDate = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2010),
        lastDate: DateTime(_dateTime.year));

    if (_pickedDate != null) {
      setState(() {
        _dateTime = _pickedDate;
        myController.text = DateFormat('yyyy-MM-dd').format(_pickedDate);
      });
    }
  }
}
