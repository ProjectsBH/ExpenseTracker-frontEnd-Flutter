import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:expense_tracker_app_api/app/category/categoryAdd.dart';
import 'package:expense_tracker_app_api/app/category/categoryEdit.dart';
import 'package:expense_tracker_app_api/components/checkResult.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app_api/components/crud.dart';
import 'package:expense_tracker_app_api/components/link_api.dart';

class CategoriesView extends StatefulWidget {
  //const CategoriesView({super.key});
  static const route = "categoryView";
  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> with Crud {
  // var categoryNameController = TextEditingController();
  // var categoryLimitAmountController = TextEditingController();
  // TextEditingController editCategoryNameController = TextEditingController();
  // TextEditingController editCategoryLimitAmountController =
  //     TextEditingController();
  getCategories() async {
    var response = await getRequest(LinkAPI.linkCategoryViews);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //_showFormDialog(context);
          Navigator.of(context).pushNamed(CategoryAdd.route);
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            FutureBuilder(
                future: getCategories(),
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
                          return Padding(
                            padding: EdgeInsets.only(
                                top: 8.0, left: 16.0, right: 16.0),
                            child: Card(
                              elevation: 8.0,
                              child: ListTile(
                                leading: IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      ////_editFormDialog(context, snapshot.data['data'][i]);

                                      // Navigator.of(context).push(
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             CategoryEdit(
                                      //                 category: snapshot
                                      //                     .data['data'][i])));

                                      Navigator.of(context).pushNamed(
                                          CategoryEdit.route,
                                          arguments: snapshot.data['data'][i]);
                                    }),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(snapshot.data['data'][i]['name']),
                                    IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          _deleteFormDialog(context,
                                              snapshot.data['data'][i]['id']);
                                        })
                                  ],
                                ),
                                subtitle: Text(
                                    // ignore: prefer_interpolation_to_compose_strings
                                    "${"الحد : " + snapshot.data['data'][i]['isLimitAmountName']} - ${snapshot.data['data'][i]['limitAmount']}"),
                              ),
                            ),
                          );
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

  _deleteFormDialog(BuildContext context, int categoryId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return Directionality(
              textDirection: TextDirection.rtl,
              child: Builder(builder: (BuildContext context) {
                return AlertDialog(
                  actions: <Widget>[
                    MaterialButton(
                      color: Colors.red,
                      onPressed: () async {
                        var response = await deleteRequest(
                            LinkAPI.linkCategoryDelete(categoryId));
                        setState(() {});
                        if (CheckResult.check(response) == true) {
                          Navigator.pop(context);
                          await getCategories();
                          _showSuccessSnackBar(context, const Text('حذف'));
                        } else {
                          AwesomeDialog(
                            context: context,
                            title: "خطأ",
                            body: Text(response['message']),
                          )..show();
                        }
                      },
                      child: const Text('حذف'),
                    ),
                    MaterialButton(
                      color: Colors.green,
                      onPressed: () => Navigator.pop(context),
                      child: const Text('إلغاء'),
                    ),
                  ],
                  title: const Text('هل أنت متأكد أنك تريد حذف هذا؟'),
                );
              }));
        });
  }

  _showSuccessSnackBar(BuildContext context, message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: Text(message),
      ),
    );
  }

/*
  bool isLoading = false;
  addCategory() async {
    if (categoryNameController.text.isEmpty) {
      return AwesomeDialog(
        context: context,
        title: "هام",
        body: const Text("الرجاء إدخال اسم التصنيف"),
      )..show();
    }
    isLoading = true;
    setState(() {});
    var response = await postRequest(linkCategoryAdd, {
      "name": categoryNameController.text,
      "isLimitAmount": _isLimitAmountChecked,
      "limitAmount": _isLimitAmountChecked
          ? num.parse(categoryLimitAmountController.text)
          : 0,
      "userId": int.parse(getUserId())
    });

    isLoading = false;
    setState(() {
      _isLimitAmountChecked = false;
    });
    //setState(() {});

    if (CheckResult.check(response) == true) {
      categoryNameController.text = "";
      categoryLimitAmountController.text = "";
      Navigator.pop(context);
      await getCategories();
    } else {
      AwesomeDialog(
        context: context,
        title: "خطأ",
        body: Text(response['message']),
      )..show();
      //Navigator.pop(context);
    }

    return response;
  }


  _showFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (param) {
          return Directionality(
              textDirection: TextDirection.rtl,
              child: Builder(builder: (BuildContext context) {
                return AlertDialog(
                  actions: <Widget>[
                    MaterialButton(
                      color: Colors.blue,
                      onPressed: () async {
                        await addCategory();
                      },
                      child: const Text('حفظ'),
                    ),
                    MaterialButton(
                      color: Colors.red,
                      onPressed: () => Navigator.pop(context),
                      child: const Text('إلغاء'),
                    ),
                  ],
                  title: const Text('الفئات'),
                  content: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: categoryNameController,
                          autofocus: true,
                          decoration: const InputDecoration(
                            hintText: 'أدخل فئة',
                            labelText: 'الفئة',
                          ),
                        ),
                        CheckboxListTile(
                          title: const Text('لها حد'),
                          value: _isLimitAmountChecked,
                          onChanged: (value) {
                            setState(() {
                              _isLimitAmountChecked = value!;
                            });
                          },
                        ),
                        if (_isLimitAmountChecked)
                          TextField(
                            keyboardType: TextInputType.number,
                            controller: categoryLimitAmountController,
                            decoration: const InputDecoration(
                                hintText: 'أدخل المبلغ',
                                labelText: 'مبلغ الحد'),
                          ),
                      ],
                    ),
                  ),
                );
              }));
        });
  }

  editCategory(String id) async {
    if (editCategoryNameController.text.isEmpty) {
      return AwesomeDialog(
        context: context,
        title: "هام",
        body: const Text("الرجاء إدخال اسم التصنيف"),
      )..show();
    }
    isLoading = true;
    setState(() {});
    var response = await putRequest(linkCategoryEdit(int.parse(id)), {
      "name": editCategoryNameController.text,
      "isLimitAmount": true,
      "limitAmount": num.parse(editCategoryLimitAmountController.text)
    });

    isLoading = false;
    setState(() {});

    if (CheckResult.check(response) == true) {
      editCategoryNameController.text = "";
      editCategoryLimitAmountController.text = "";
      Navigator.pop(context);
      await getCategories();
    } else {
      AwesomeDialog(
        context: context,
        title: "خطأ",
        body: Text(response['message']),
      )..show();
      //_showSuccessSnackBar(context, Text(response['message']));
    }

    return response;
  }

  _editFormDialog(BuildContext context, category) {
    late String id;
    setState(() {
      id = category['id'].toString();
      editCategoryNameController.text = category['name'] ?? 'لايوجد اسم';
      editCategoryLimitAmountController.text =
          category['limitAmount'].toString();
    });
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (param) {
          return Directionality(
              textDirection: TextDirection.rtl,
              child: Builder(builder: (BuildContext context) {
                return AlertDialog(
                  actions: <Widget>[
                    MaterialButton(
                      color: Colors.blue,
                      onPressed: () async {
                        await editCategory(id);
                      },
                      child: const Text('حفظ'),
                    ),
                    MaterialButton(
                      color: Colors.red,
                      onPressed: () => Navigator.pop(context),
                      child: const Text('إلغاء'),
                    ),
                  ],
                  title: const Text('الفئات'),
                  content: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: editCategoryNameController,
                          autofocus: true,
                          decoration: const InputDecoration(
                            hintText: 'أدخل فئة',
                            labelText: 'الفئة',
                          ),
                        ),
                        TextField(
                          controller: editCategoryLimitAmountController,
                          decoration: const InputDecoration(
                              hintText: 'أدخل وصف', labelText: 'الوصف'),
                        )
                      ],
                    ),
                  ),
                );
              }));
        });
  }
*/
}
