import 'package:expense_tracker_app_api/app/auth/login.dart';
import 'package:expense_tracker_app_api/app/category/categoryAdd.dart';
import 'package:expense_tracker_app_api/app/category/categoryEdit.dart';
import 'package:expense_tracker_app_api/app/expenses/expensesReport.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app_api/app/auth/signup.dart';
import 'package:expense_tracker_app_api/app/auth/success.dart';
import 'package:expense_tracker_app_api/app/category/categories_view.dart';
import 'package:expense_tracker_app_api/app/expenses/expenseAdd.dart';
import 'package:expense_tracker_app_api/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker API',
      initialRoute: sharedPref.getString("id") == null
          ? Login.route
          : Home.route, //CategoriesView.route,
      onGenerateRoute: (settg) {
        if (settg.name == CategoryEdit.route) {
          final categ = settg.arguments;
          return MaterialPageRoute(
            builder: (context) => CategoryEdit(
              category: categ,
            ),
          );
        }
      },

      routes: {
        Login.route: (context) => Login(),
        SignUp.route: (context) => SignUp(),
        Home.route: (context) => Home(),
        Success.route: (context) => Success(),
        AddExpense.route: (context) => AddExpense(),
        //EditNote.route: (context) => EditNote(),
        CategoriesView.route: (context) => CategoriesView(),
        CategoryAdd.route: (context) => CategoryAdd(),
        ExpensesReport.route: (context) => ExpensesReport(),
      },
    );
  }
}
