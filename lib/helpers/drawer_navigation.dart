import 'package:expense_tracker_app_api/app/expenses/expensesReport.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app_api/app/category/categories_view.dart';
import 'package:expense_tracker_app_api/components/crud.dart';
import 'package:expense_tracker_app_api/components/link_api.dart';
import 'package:expense_tracker_app_api/home.dart';

class DrawerNavigaton extends StatefulWidget {
  @override
  _DrawerNavigatonState createState() => _DrawerNavigatonState();
}

class _DrawerNavigatonState extends State<DrawerNavigaton> with Crud {
  final List<Widget> _categoryList = [];

  //CategoryService _categoryService = CategoryService();

  @override
  initState() {
    super.initState();
    getAllCategories();
  }

  getAllCategories() async {
    var categories = await getRequest(LinkAPI.linkCategoryViews);
    //return response;
    categories.forEach((category) {
      setState(() {
        _categoryList.add(InkWell(
          onTap: () => Navigator.of(context).pushNamed(Home.route),
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => Home() //Home.route
          //       new TransByCategory(
          //         category: category['name'],
          //       ),
          //       ),
          //),
          child: ListTile(
            title: Text(category["data"]['name']),
          ),
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                  //backgroundImage: AssetImage('assets/prson_logo.png'),
                  ),
              accountName: Text('Basheer Hezam'),
              accountEmail: Text('basheerhezam@gmail.com'),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
                leading: Icon(Icons.home),
                title: Text('الرئيسية'),
                onTap: () => Navigator.of(context)
                    .pushNamedAndRemoveUntil(Home.route, (route) => false)
                // Navigator.of(context)
                //       .push(MaterialPageRoute(builder: (context) => Home.route)),
                ),
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text('الفئات'),
              onTap: () =>
                  Navigator.of(context).pushNamed(CategoriesView.route),
            ),
            ListTile(
              leading: Icon(Icons.repeat),
              title: Text('تقرير المصروفات'),
              onTap: () =>
                  Navigator.of(context).pushNamed(ExpensesReport.route),
            ),
            Divider(),
            Column(
              children: _categoryList,
            ),
          ],
        ),
      ),
    );
  }
}
