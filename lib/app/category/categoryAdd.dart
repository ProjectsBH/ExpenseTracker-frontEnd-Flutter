import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:expense_tracker_app_api/app/category/categories_view.dart';
import 'package:expense_tracker_app_api/components/checkResult.dart';
import 'package:expense_tracker_app_api/components/crud.dart';
import 'package:expense_tracker_app_api/components/customTextForm.dart';
import 'package:expense_tracker_app_api/components/functions.dart';
import 'package:expense_tracker_app_api/components/link_api.dart';
import 'package:expense_tracker_app_api/components/valid_input.dart';
import 'package:flutter/material.dart';

class CategoryAdd extends StatefulWidget {
  static const route = "categoryAdd";
  //const CategoryAdd({super.key});

  @override
  State<CategoryAdd> createState() => _CategoryAddState();
}

class _CategoryAddState extends State<CategoryAdd> with Crud {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  var categoryNameController = TextEditingController();
  var categoryLimitAmountController = TextEditingController();
  //var resultController = TextEditingController();
  bool _isLimitAmountChecked = false;

  bool isLoading = false;
  addCategory() async {
    if (formstate.currentState!.validate()) {
      if (categoryNameController.text.isEmpty) {
        return AwesomeDialog(
          context: context,
          title: "هام",
          body: const Text("الرجاء إدخال اسم التصنيف"),
        )..show();
      }
      isLoading = true;
      setState(() {});
      var response = await postRequest(LinkAPI.linkCategoryAdd, {
        "name": categoryNameController.text,
        "isLimitAmount": _isLimitAmountChecked,
        "limitAmount": _isLimitAmountChecked
            ? num.parse(categoryLimitAmountController.text)
            : 0,
        "userId": int.parse(getUserId())
      });

      isLoading = false;
      setState(() {
        _isLimitAmountChecked = false;
      });
      //setState(() {});

      if (CheckResult.check(response) == true) {
        categoryNameController.text = "";
        categoryLimitAmountController.text = "";
        Navigator.of(context).pushReplacementNamed(CategoriesView.route);
      } else {
        AwesomeDialog(
          context: context,
          title: "خطأ",
          body: Text(response['message']),
        )..show();
      }

      return response;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Category"),
        ),
        body: isLoading == true
            ? const Center(child: CircularProgressIndicator())
            : Container(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: formstate,
                  child: ListView(
                    children: [
                      Container(
                        height: 20,
                      ),
                      CustomTextForm(
                        valid: (val) {
                          return validInput(val!, 3, 40);
                        },
                        myController: categoryNameController,
                        hint: "name",
                      ),
                      CheckboxListTile(
                        title: const Text('لها حد'),
                        value: _isLimitAmountChecked,
                        onChanged: (value) {
                          setState(() {
                            _isLimitAmountChecked = value!;
                          });
                        },
                      ),
                      if (_isLimitAmountChecked)
                        CustomTextForm(
                          valid: (val) {
                            if (_isLimitAmountChecked &&
                                (val == null || num.parse(val) < 1))
                              return "إدخال مبلغ الحد";
                            return validInput(val!, 2, 5);
                          },
                          myController: categoryLimitAmountController,
                          hint: "مبلغ الحد",
                          textInputType: TextInputType.number,
                          //keyboardType: TextInputType.number,
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
                          await addCategory();
                        },
                        child: const Text("Add Category"),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
