import 'package:expense_tracker_app_api/components/message.dart';
import 'package:email_validator/email_validator.dart';

validInput(String val, int min, int max) {
  if (val.isEmpty) return messageInputEmpty;

  if (val.length > max) return "$messageInputMax is $max";

  if (val.length < min) return "$messageInputMin is $min";
}

validInputEmpty(String val) {
  if (val.isEmpty) return messageInputEmpty;
}

validInputAmount(String val) {
  if (val.isEmpty || num.parse(val) < 1) return "إدخال مبلغ";
}

validInputEmail(String val) {
  //return validInput(val, min, max);
  if (EmailValidator.validate(val) == false) return messageInputEmail;
}
