import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:expense_tracker_app_api/components/checkResult.dart';
import 'package:expense_tracker_app_api/components/customTextDateForm.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app_api/components/crud.dart';
import 'package:expense_tracker_app_api/components/customTextForm.dart';
import 'package:expense_tracker_app_api/components/functions.dart';
import 'package:expense_tracker_app_api/components/link_api.dart';
import 'package:expense_tracker_app_api/components/valid_input.dart';
import 'package:expense_tracker_app_api/home.dart';
import 'package:expense_tracker_app_api/models/expenseCategoryModel.dart';
import 'package:intl/intl.dart';

class AddExpense extends StatefulWidget {
  static const route = "addExpense";

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> with Crud {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  TextEditingController theDateController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController statementController = TextEditingController();

  ExpenseCategoryModel? _selectedValue;
  List<ExpenseCategoryModel> dropdownValues = [];
  @override
  void initState() {
    super.initState();
    fetchDropdownData().then((values) {
      setState(() {
        dropdownValues = values;
      });
    }).catchError((error) {
      // يمكنك تنفيذ التعامل مع الأخطاء هنا
      print('Error fetching dropdown data: $error');
    });
  }

  Future<List<ExpenseCategoryModel>> fetchDropdownData() async {
    var response = await getRequest(LinkAPI.linkCategoryViews);

    List<ExpenseCategoryModel> data = [];
    data = List<ExpenseCategoryModel>.from(
        response['data'].map((item) => ExpenseCategoryModel.fromJson(item)));
    return data;
  }

  bool isLoading = false;
  addExpense() async {
    if (formstate.currentState!.validate()) {
      if (_selectedValue == null || _selectedValue!.id! < 1) {
        return AwesomeDialog(
          context: context,
          title: "هام",
          body: const Text("الرجاء إدخال اسم التصنيف"),
        )..show();
      }
      isLoading = true;
      setState(() {});
      var response = await postRequest(
        LinkAPI.linkExpenseAdd,
        {
          "categoryId": _selectedValue!.id,
          "theDate": theDateController.text,
          "amount": amountController.text,
          "theStatement": statementController.text,
          "userId": getUserId()
        },
      );

      isLoading = false;
      setState(() {});

      if (CheckResult.check(response)) {
        Navigator.of(context).pushReplacementNamed(Home.route);
      } else {}

      return response;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Expense"),
      ),
      body: isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : Container(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: formstate,
                child: ListView(
                  children: [
                    DropdownButtonFormField(
                      value: _selectedValue,
                      items: dropdownValues
                          .map((idType) => DropdownMenuItem(
                              value: idType,
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "${idType.name}",
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    //color: AppColors.secondaryBackground,
                                  ),
                                ),
                              )))
                          .toList(),
                      onChanged: (value) => _selectedValue = value,
                      hint: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "إختر فئة",
                          style: TextStyle(
                            //color: AppColors.secondaryBackground,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),

                    Container(
                      height: 20,
                    ),
                    customTextDateForm(
                      valid: (val) {
                        return validInputEmpty(val!);
                      },
                      myController: theDateController,
                      hint: "التاريخ",
                    ),
                    // TextFormField(
                    //   controller: theDateController,
                    //   decoration: InputDecoration(
                    //     hintText: 'التاريخ',
                    //     prefixIcon: InkWell(
                    //       onTap: () {
                    //         _selectedTransDate(context, theDateController);
                    //       },
                    //       child: Icon(Icons.calendar_today),
                    //     ),
                    //   ),
                    //   validator: (value) {
                    //     return validInputEmpty(value!);
                    //   },
                    // ),

                    CustomTextForm(
                      valid: (val) {
                        return validInputAmount(val!);
                      },
                      myController: amountController,
                      hint: "المبلغ",
                      textInputType: TextInputType.number,
                    ),
                    CustomTextForm(
                      valid: (val) {
                        return validInput(val!, 5, 255);
                      },
                      myController: statementController,
                      hint: "البيان",
                    ),
                    Container(
                      height: 20,
                    ),
                    MaterialButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 70, vertical: 10),
                      onPressed: () async {
                        await addExpense();
                      },
                      child: const Text("Add Expense"),
                    ),
                  ],
                ),
              )),
    );
  }

/*
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
    */
}
