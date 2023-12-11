import 'package:expense_tracker_app_api/components/cardExpensesBH.dart';
import 'package:expense_tracker_app_api/components/checkResult.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app_api/app/auth/login.dart';
import 'package:expense_tracker_app_api/app/expenses/expenseAdd.dart';
import 'package:expense_tracker_app_api/app/expenses/expenseEdit.dart';
import 'package:expense_tracker_app_api/components/cardExpenses.dart';
import 'package:expense_tracker_app_api/components/crud.dart';
import 'package:expense_tracker_app_api/components/link_api.dart';
import 'package:expense_tracker_app_api/helpers/drawer_navigation.dart';
import 'package:expense_tracker_app_api/main.dart';
import 'package:expense_tracker_app_api/models/expenseModel.dart';

class Home extends StatefulWidget {
  static const route = "home";
  //Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with Crud {
  getExpenses() async {
    var response = await getRequest(LinkAPI.linkExpenseViews);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
              onPressed: () {
                sharedPref.clear();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(Login.route, (route) => false);
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      drawer: DrawerNavigaton(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddExpense.route);
        },
        child: Icon(Icons.add),
      ),
      body: Container(
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
                            expenseModel:
                                ExpenseModel.fromJson(snapshot.data['data'][i]),
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
                                Navigator.of(context)
                                    .pushReplacementNamed(Home.route);
                              }
                            },
                          );
                          /*
                          return CardExpenses(
                            noteModel:
                                ExpenseModel.fromJson(snapshot.data['data'][i]),
                            onTapFun: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditExpense(
                                      expenses: snapshot.data['data'][i])));
                            },
                            onDelete: () async {
                              var response = await deleteRequest(
                                  LinkAPI.linkExpenseDelete(
                                      snapshot.data['data'][i]['id']));

                              if (CheckResult.check(response) == true) {
                                Navigator.of(context)
                                    .pushReplacementNamed(Home.route);
                              }
                            },
                          );
                          */
                        });
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: Text("Loading ......"));
                  }
                  return const Center(child: Text("Loading Unlimited ......"));
                }),
          ],
        ),
      ),
    );
  }
}
