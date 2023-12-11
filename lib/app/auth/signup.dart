import 'package:expense_tracker_app_api/components/checkResult.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app_api/app/auth/login.dart';
import 'package:expense_tracker_app_api/app/auth/success.dart';
import 'package:expense_tracker_app_api/components/crud.dart';
import 'package:expense_tracker_app_api/components/customTextForm.dart';
import 'package:expense_tracker_app_api/components/link_api.dart';
import 'package:expense_tracker_app_api/components/valid_input.dart';

class SignUp extends StatefulWidget {
  static const route = "/signUp";

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formState = GlobalKey();
  final Crud _crud = Crud();

  bool isloading = false;

  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerConfirmPassword = TextEditingController();

  signUp() async {
    if (formState.currentState!.validate()) {
      isloading = true;
      setState(() {});
      var response = await _crud.postRequest(LinkAPI.linkSignUp, {
        "userName": controllerUsername.text,
        "email": controllerEmail.text,
        "password": controllerPassword.text,
        "confirmPassword": controllerConfirmPassword.text
      });

      isloading = false;
      setState(() {});
      if (CheckResult.check(response) == true) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Success.route, (route) => false);
      } else {
        if (kDebugMode) {
          print("SignUp Fail");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isloading == true
            ? Center(child: CircularProgressIndicator())
            : Container(
                padding: const EdgeInsets.all(10),
                child: ListView(
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
                              return validInputEmail(val!);
                            },
                            myController: controllerEmail,
                            hint: "email",
                          ),
                          CustomTextForm(
                            valid: (val) {
                              return validInput(val!, 6, 20);
                            },
                            myController: controllerPassword,
                            hint: "password",
                          ),
                          CustomTextForm(
                            valid: (val) {
                              return validInput(val!, 6, 20);
                            },
                            myController: controllerConfirmPassword,
                            hint: "confirmPassword",
                          ),
                          MaterialButton(
                            color: Colors.blue,
                            textColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 70, vertical: 10),
                            onPressed: () async {
                              await signUp();
                            },
                            child: const Text("Sign Up"),
                          ),
                          Container(
                            height: 10,
                          ),
                          InkWell(
                            child: const Text("Login"),
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(Login.route);
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
