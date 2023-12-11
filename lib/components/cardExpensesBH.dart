import 'package:flutter/material.dart';
import 'package:expense_tracker_app_api/models/expenseModel.dart';

class CardExpensesBH extends StatelessWidget {
  final Function()? onEdit;
  final ExpenseModel expenseModel;
  final void Function()? onDelete;
  const CardExpensesBH(
      {Key? key,
      required this.onEdit,
      required this.expenseModel,
      required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          child: ListTile(
            leading: IconButton(icon: Icon(Icons.edit), onPressed: onEdit),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(expenseModel.amount.toString() ?? 'لا يوجد مبلغ'),
                      Text(expenseModel.theStatement ?? 'لايوجد وصف'),
                    ]),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(expenseModel.categoryName ?? 'لايوجد فئة'),
                      Text(expenseModel.theDate ?? 'لايوجد تاريخ'),
                    ]),
                IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
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
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('إلغاء'),
                                ),
                              ],
                              title: const Text("تنبيه"),
                              content: Text(
                                  'هل أنت متأكد في حذف عملية من فئة: ${expenseModel.categoryName} بالتأكيد ؟'),
                            );
                          });
                    })
              ],
            ),
          )),
    );
  }
}
