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

class ExpensesReport22 extends StatefulWidget {
  //const ExpensesReport({super.key});
  static const route = "expensesReport";
  @override
  State<ExpensesReport22> createState() => _ExpensesReport22State();
}

class _ExpensesReport22State extends State<ExpensesReport22> with Crud {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  TextEditingController theDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();

  bool isLoading = false;
  getExpenses() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await getRequest(LinkAPI.linkExpensesReportViews(
          theDateController.text, toDateController.text));
      isLoading = false;
      setState(() {}); //response.statusCode == 200
      if (CheckResult.check(response) == false) {
        return AwesomeDialog(
          context: context,
          title: "خطأ",
          body: Text(response["message"]),
        )..show();
      }

      return response;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Report Expenses"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Form(
              key: formstate,
              child: ListView(
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
                    onPressed: () {
                      setState(() {
                        //getExpensesWidget(context, true);
                      });
                    },
                    // onPressed: () async {
                    //   await getExpenses();
                    // },
                    child: const Text("Get Expenses"),
                  ),
                  Container(
                    height: 20,
                  ),
                ],
              ),
            ),
            getExpensesWidget(context, false),
          ],
        ),
      ),
    );
  }

  Widget getExpensesWidget(BuildContext context, bool isExecute) {
    if (isExecute == false) {
      return Container(
        height: 20,
      );
    }
    return isLoading == true
        ? const Center(child: CircularProgressIndicator())
        : Container(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: [
                FutureBuilder(
                    future: getExpenses(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        if (CheckResult.check(snapshot.data) == false)
                          return Center(
                            child: Text(
                              "No Data ...",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        return ListView.builder(
                            itemCount: snapshot.data['data'].length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, i) {
                              return CardExpensesBH(
                                expenseModel: ExpenseModel.fromJson(
                                    snapshot.data['data'][i]),
                                onEdit: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => EditExpense(
                                          expenses: snapshot.data['data'][i])));
                                },
                                onDelete: () async {
                                  var response = await deleteRequest(
                                      LinkAPI.linkExpenseDelete(
                                          snapshot.data['data'][i]['id']));

                                  if (CheckResult.check(response) == true) {
                                    //Navigator.of(context).pushReplacementNamed(Home.route);
                                    getExpensesWidget(context, true);
                                  }
                                },
                              );
                            });
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: Text("Loading ......"));
                      }
                      return const Center(
                          child: Text("Loading Unlimited ......"));
                    }),
              ],
            ),
          );
  }
}
