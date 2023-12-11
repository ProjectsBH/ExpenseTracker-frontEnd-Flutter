class LinkAPI {
  static APILanguage apiLanguage = APILanguage.Php;
  //static String urlServer = "http://localhost:8012/expenseTrackerApi";

  static String get urlServer {
    String value = "";
    switch (apiLanguage) {
      case APILanguage.CSharp:
        value = "http://localhost:5297/api/";
        break;
      case APILanguage.Php:
        value = "http://localhost:8012/expenseTrackerApi/";
        break;
      case APILanguage.NodeJS:
        value = "http://localhost:3000/";
        break;
      case APILanguage.Python:
      case APILanguage.Java:
        value = "";
        break;
      //default:
      //    value = ""; break;
    }
    return value;
  }

// Auth
  static String get linkUser {
    String value = urlServer;
    switch (apiLanguage) {
      case APILanguage.CSharp:
      case APILanguage.Java:
        value += "user";
        break;
      case APILanguage.Php:
      case APILanguage.NodeJS:
        value += "auth";
        break;
      case APILanguage.Python:
        value += "auth";
        break;
    }
    return value;
  }

  static String get linkLogin {
    String value = "";
    switch (apiLanguage) {
      case APILanguage.CSharp:
      case APILanguage.NodeJS:
      case APILanguage.Java:
        value = "$linkUser/login";
        break;
      case APILanguage.Php:
        value = "$linkUser/login.php";
        break;
      case APILanguage.Python:
        value = "$linkUser";
        break;
    }
    return value;
  }

  static String get linkSignUp {
    String value = "";
    switch (apiLanguage) {
      case APILanguage.CSharp:
      case APILanguage.NodeJS:
      case APILanguage.Java:
        value = "$linkUser/signUp";
        break;
      case APILanguage.Php:
        value = "$linkUser/signup.php";
        break;
      case APILanguage.Python:
        value = "$linkUser";
        break;
    }
    return value;
  }

// expenses
  static String get linkExpense {
    String value = urlServer;
    switch (apiLanguage) {
      case APILanguage.CSharp:
      case APILanguage.NodeJS:
      case APILanguage.Java:
        value += "expenses";
        break;
      case APILanguage.Php:
        value += "expenses";
        break;
      case APILanguage.Python:
        value += "expenses";
        break;
    }
    return value;
  }

  static String get linkExpenseViews {
    String value = "";
    switch (apiLanguage) {
      case APILanguage.CSharp:
      case APILanguage.NodeJS:
      case APILanguage.Java:
        value = linkExpense;
        break;
      case APILanguage.Php:
        value = "$linkExpense/views.php";
        break;
      case APILanguage.Python:
        value = "$linkExpense";
        break;
    }
    return value;
  }

  static String linkExpenseViewBy(BigInt id) {
    String value = "";
    switch (apiLanguage) {
      case APILanguage.CSharp:
      case APILanguage.NodeJS:
      case APILanguage.Java:
        value = "$linkExpense/$id";
        break;
      case APILanguage.Php:
        value = "$linkExpense/viewBy.php?id=$id";
        break;
      case APILanguage.Python:
        value = "$linkExpense";
        break;
    }
    return value;
  }

  static String get linkExpenseAdd {
    String value = "";
    switch (apiLanguage) {
      case APILanguage.CSharp:
      case APILanguage.NodeJS:
      case APILanguage.Java:
        value = linkExpense;
        break;
      case APILanguage.Php:
        value = "$linkExpense/add.php";
        break;
      case APILanguage.Python:
        value = "$linkExpense";
        break;
    }
    return value;
  }

  static String linkExpenseEdit(String id) {
    String value = "";
    switch (apiLanguage) {
      case APILanguage.CSharp:
      case APILanguage.NodeJS:
      case APILanguage.Java:
        value = "$linkExpense/$id";
        break;
      case APILanguage.Php:
        value = "$linkExpense/edit.php?id=$id";
        break;
      case APILanguage.Python:
        value = "$linkExpense";
        break;
    }
    return value;
  }

  static String linkExpenseDelete(String id) {
    String value = "";
    switch (apiLanguage) {
      case APILanguage.CSharp:
      case APILanguage.NodeJS:
      case APILanguage.Java:
        value = "$linkExpense/$id";
        break;
      case APILanguage.Php:
        value = "$linkExpense/delete.php?id=$id";
        break;
      case APILanguage.Python:
        value = "$linkExpense";
        break;
    }
    return value;
  }

// expenseCategory
  static String get linkCategory {
    String value = urlServer;
    switch (apiLanguage) {
      case APILanguage.CSharp:
        value += "expenseCategory";
        break;
      case APILanguage.Php:
      case APILanguage.NodeJS:
      case APILanguage.Java:
        value += "category";
        break;
      case APILanguage.Python:
        value += "category";
        break;
    }
    return value;
  }

  static String get linkCategoryGetTitle {
    String value = "";
    switch (apiLanguage) {
      case APILanguage.CSharp:
      case APILanguage.NodeJS:
      case APILanguage.Java:
        value = "$linkCategory/getTitle";
        break;
      case APILanguage.Php:
        value = "$linkCategory/getTitle.php";
        break;
      case APILanguage.Python:
        value = "$linkCategory/getTitle";
        break;
    }
    return value;
  }

  static String get linkCategoryViews {
    String value = "";
    switch (apiLanguage) {
      case APILanguage.CSharp:
      case APILanguage.NodeJS:
      case APILanguage.Java:
        value = linkCategory;
        break;
      case APILanguage.Php:
        value = "$linkCategory/views.php";
        break;
      case APILanguage.Python:
        value = "$linkCategory/g";
        break;
    }
    return value;
  }

  static String get linkCategoryValueId {
    String value = "";
    switch (apiLanguage) {
      case APILanguage.CSharp:
      case APILanguage.NodeJS:
      case APILanguage.Java:
        value = "$linkCategory/valueId";
        break;
      case APILanguage.Php:
        value = "$linkCategory/valueId.php";
        break;
      case APILanguage.Python:
        value = "$linkCategory";
        break;
    }
    return value;
  }

  static String get linkCategoryAdd {
    String value = "";
    switch (apiLanguage) {
      case APILanguage.CSharp:
      case APILanguage.NodeJS:
      case APILanguage.Java:
        value = linkCategory;
        break;
      case APILanguage.Php:
        value = "$linkCategory/add.php";
        break;
      case APILanguage.Python:
        value = "$linkCategory";
        break;
    }
    return value;
  }

  //static String linkCategoryEdit(int id) => "$urlServer/category/edit.php?id=$id";
  static String linkCategoryEdit(int id) {
    String value = "";
    switch (apiLanguage) {
      case APILanguage.CSharp:
      case APILanguage.NodeJS:
      case APILanguage.Java:
        value = "$linkCategory/$id";
        break;
      case APILanguage.Php:
        value = "$linkCategory/edit.php?id=$id";
        break;
      case APILanguage.Python:
        value = "$linkCategory";
        break;
    }
    return value;
  }

  static String linkCategoryDelete(int id) {
    String value = "";
    switch (apiLanguage) {
      case APILanguage.CSharp:
      case APILanguage.NodeJS:
      case APILanguage.Java:
        value = "$linkCategory/$id";
        break;
      case APILanguage.Php:
        value = "$linkCategory/delete.php?categoryId=$id";
        break;
      case APILanguage.Python:
        value = "$linkCategory";
        break;
    }
    return value;
  }

  //ExpensesReport
  static String get linkExpensesReport {
    String value = urlServer;
    switch (apiLanguage) {
      case APILanguage.CSharp:
      case APILanguage.NodeJS:
      case APILanguage.Java:
        value += "expensesReport";
        break;
      case APILanguage.Php:
        value += "expensesReport";
        break;
      case APILanguage.Python:
        value += "expensesReport";
        break;
    }
    return value;
  }

  static String linkExpensesReportViews(String fromDate, String toDate) {
    String value = "";
    switch (apiLanguage) {
      case APILanguage.CSharp:
      case APILanguage.NodeJS:
      case APILanguage.Java:
        value =
            "$linkExpensesReport/getByDates?fromDate=$fromDate&toDate=$toDate";
        break;
      case APILanguage.Php:
        value =
            "$linkExpensesReport/getByDates.php?fromDate=$fromDate&toDate=$toDate";
        break;
      case APILanguage.Python:
        value = "$linkExpensesReport";
        break;
    }
    return value;
  }
}

enum APILanguage {
  CSharp,
  Php,
  Python,
  NodeJS,
  Java,
}
