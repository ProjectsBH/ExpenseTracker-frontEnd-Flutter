import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:expense_tracker_app_api/components/checkResult.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app_api/app/auth/signup.dart';
import 'package:expense_tracker_app_api/components/crud.dart';
import 'package:expense_tracker_app_api/components/customTextForm.dart';
import 'package:expense_tracker_app_api/components/link_api.dart';
import 'package:expense_tracker_app_api/components/valid_input.dart';
import 'package:expense_tracker_app_api/home.dart';
import 'package:expense_tracker_app_api/main.dart';

class Login extends StatefulWidget {
  static const route = "/";
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formState = GlobalKey();

  final Crud _crud = Crud();

  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  bool isloading = false;
  login() async {
    if (formState.currentState!.validate()) {
      isloading = true;
      setState(() {});
      var response = await _crud.postRequest(LinkAPI.linkLogin, {
        "userName": controllerUsername.text,
        "password": controllerPassword.text
      });
      isloading = false;
      setState(() {});
      if (CheckResult.check(response) == true) {
        sharedPref.setString("id", response["data"]['id'].toString());
        sharedPref.setString("username", response["data"]['userName']);
        sharedPref.setString("email", response["data"]['email']);
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Home.route, (route) => false);
      } else {
        AwesomeDialog(
                context: context,
                //btnCancel: Text("Cancel"),
                title: "تنبيه",
                body: Text("بيانات تسجيل الدخول غير صحيحة"))
            .show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(10),
      child: isloading == true
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                Form(
                  key: formState,
                  child: Column(
                    children: [
                      Image.asset(
                        "images/logo.png",
                        width: 200,
                        height: 200,
                      ),
                      //TextFormField(),
                      CustomTextForm(
                        valid: (val) {
                          return validInput(val!, 5, 10);
                        },
                        myController: controllerUsername,
                        hint: "username",
                      ),
                      CustomTextForm(
                        valid: (val) {
                          return validInput(val!, 6, 20);
                        },
                        myController: controllerPassword,
                        hint: "password",
                      ),
                      MaterialButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 70, vertical: 10),
                        onPressed: () async {
                          await login();
                          //Navigator.of(context).pushReplacementNamed(Home.route);
                        },
                        child: const Text("Login"),
                      ),
                      Container(
                        height: 10,
                      ),
                      InkWell(
                        child: const Text("Sign Up"),
                        onTap: () {
                          Navigator.of(context).pushNamed(SignUp.route);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
    ));
  }
}
