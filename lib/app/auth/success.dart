import 'package:flutter/material.dart';
import 'package:expense_tracker_app_api/app/auth/login.dart';

class Success extends StatefulWidget {
  //const Success({super.key});
  static const route = "success";
  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Center(
          child: Text(
            "تم إنشاء الحساب بنجاح الان يمكنك تسجيل الدخول",
            style: TextStyle(fontSize: 20),
          ),
        ),
        MaterialButton(
          textColor: Colors.white,
          color: Colors.blue,
          onPressed: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(Login.route, (route) => false);
          },
          child: const Text("تسجيل الدخول"),
        ),
      ]),
    );
  }
}
