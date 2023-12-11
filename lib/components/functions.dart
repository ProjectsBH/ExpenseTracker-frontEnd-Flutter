import 'package:expense_tracker_app_api/main.dart';

String getUserId() {
  //return "1";
  return sharedPref.getString("id")!;
}
