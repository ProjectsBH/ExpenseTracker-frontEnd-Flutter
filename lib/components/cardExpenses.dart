import 'package:flutter/material.dart';
import 'package:expense_tracker_app_api/models/expenseModel.dart';

class CardExpenses extends StatelessWidget {
  final Function()? onTapFun;
  final ExpenseModel noteModel;
  final void Function()? onDelete;
  const CardExpenses(
      {Key? key,
      required this.onTapFun,
      required this.noteModel,
      required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapFun,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                //flex: 2,
                child: ListTile(
                  title: Text("${noteModel.theDate} - ${noteModel.amount}"),
                  subtitle: Text(
                      "${noteModel.theStatement} - ${noteModel.categoryName}"),
                  trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                actions: <Widget>[
                                  MaterialButton(
                                    color: Colors.red,
                                    onPressed: onDelete,
                                    child: const Text('حذف'),
                                  ),
                                  MaterialButton(
                                    color: Colors.green,
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('إلغاء'),
                                  ),
                                ],
                                title: const Text("تنبيه"),
                                content: Text(
                                    'هل أنت متأكد في حذف عملية من فئة: ${noteModel.categoryName} بالتأكيد ؟'),
                              );
                            });
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
