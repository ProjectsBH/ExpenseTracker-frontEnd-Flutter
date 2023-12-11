// https://javiercbk.github.io/json_to_dart/
class ExpenseModel {
  String? id;
  String? categoryId;
  String? theDate;
  String? amount;
  String? theStatement;
  String? categoryName;
  String? createdIn;
  String? createdBy;

  ExpenseModel(
      {this.id,
      this.categoryId,
      this.theDate,
      this.amount,
      this.theStatement,
      this.categoryName,
      this.createdIn,
      this.createdBy});

  ExpenseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['categoryId'];
    theDate = json['theDate'];
    amount = json['amount'];
    theStatement = json['theStatement'];
    categoryName = json['categoryName'];
    createdIn = json['created_in'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryId'] = this.categoryId;
    data['theDate'] = this.theDate;
    data['amount'] = this.amount;
    data['theStatement'] = this.theStatement;
    data['categoryName'] = this.categoryName;
    data['created_in'] = this.createdIn;
    data['created_by'] = this.createdBy;
    return data;
  }

  static Map<String, dynamic> toJsonBH(ExpenseModel item) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = item.id;
    data['categoryId'] = item.categoryId;
    data['theDate'] = item.theDate;
    data['amount'] = item.amount;
    data['theStatement'] = item.theStatement;
    data['categoryName'] = item.categoryName;
    data['created_in'] = item.createdIn;
    data['created_by'] = item.createdBy;
    return data;
  }
}
