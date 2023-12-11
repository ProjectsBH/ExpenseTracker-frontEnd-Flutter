import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:expense_tracker_app_api/app/expenses/expenseEdit.dart';
import 'package:expense_tracker_app_api/components/cardExpensesBH.dart';
import 'package:expense_tracker_app_api/components/checkResult.dart';
import 'package:expense_tracker_app_api/components/crud.dart';
import 'package:expense_tracker_app_api/components/customTextDateForm.dart';
import 'package:expense_tracker_app_api/components/link_api.dart';
import 'package:expense_tracker_app_api/components/valid_input.dart';
import 'package:expense_tracker_app_api/models/expenseModel.dart';
import 'package:flutter/material.dart';

class ExpensesReport extends StatefulWidget {
  //const ExpensesReport({super.key});
  static const route = "expensesReport";
  @override
  State<ExpensesReport> createState() => _ExpensesReportState();
}

class _ExpensesReportState extends State<ExpensesReport> with Crud {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  TextEditingController theDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  List<ExpenseModel> data = [];
  bool isLoading = false;
  getExpenses() async {
    try {
      if (formstate.currentState!.validate()) {
        isLoading = true;
        setState(() {});
        var response = await getRequest(LinkAPI.linkExpensesReportViews(
            theDateController.text, toDateController.text));
        //var response = await getRequest(LinkAPI.linkExpenseViews);
        //print("response Report Expenses :- " + response.toString());
        isLoading = false;
        setState(() {
          data = List<ExpenseModel>.from(
              response['data'].map((item) => ExpenseModel.fromJson(item)));
        });
        //response.statusCode == 200
        if (CheckResult.check(response) == false) {
          return AwesomeDialog(
            context: context,
            title: "خطأ",
            body: Text(response["message"]),
          )..show();
        }

        //return response;
      }
    } catch (e) {
      return AwesomeDialog(
        context: context,
        title: "catch",
        body: Text(e.toString()),
      )..show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report Expenses'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              key: formstate,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  customTextDateForm(
                    valid: (val) {
                      return validInputEmpty(val!);
                    },
                    myController: theDateController,
                    hint: "من تاريخ",
                  ),
                  customTextDateForm(
                    valid: (val) {
                      return validInputEmpty(val!);
                    },
                    myController: toDateController,
                    hint: "الى تاريخ",
                  ),
                  MaterialButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 70, vertical: 10),
                    onPressed: () async {
                      await getExpenses();
                    },
                    child: const Text("Get Expenses"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            const Text('Search Results:'),
            Expanded(
              child: (data.isEmpty)
                  ? const Center(
                      child: Text(
                        "No Data ...",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: data.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int i) {
                        return CardExpensesBH(
                          expenseModel: data[i],
                          onEdit: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EditExpense(
                                expenses: ExpenseModel.toJsonBH(data[i]),
                              ),
                            ));
                          },
                          onDelete: () async {
                            var response = await deleteRequest(
                                LinkAPI.linkExpenseDelete(
                                    data[i].id.toString()));

                            if (CheckResult.check(response) == true) {
                              setState(() {
                                Navigator.of(context).pop();
                                getExpenses();
                              });
                            }
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
