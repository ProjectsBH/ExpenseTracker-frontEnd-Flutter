class ExpenseCategoryModel {
  int? id;
  String? name;
  bool? isLimitAmount;
  double? limitAmount;
  String? isLimitAmountName;
  String? createdIn;
  int? createdBy;

  ExpenseCategoryModel(
      {this.id,
      this.name,
      this.isLimitAmount,
      this.limitAmount,
      this.isLimitAmountName,
      this.createdIn,
      this.createdBy});

  ExpenseCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isLimitAmount = json['isLimitAmount'];
    limitAmount = json['limitAmount'];
    isLimitAmountName = json['isLimitAmountName'];
    createdIn = json['created_in'];
    createdBy = json['created_by'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = Map<String, dynamic>();
  //   data['id'] = id;
  //   data['name'] = name;
  //   data['isLimitAmount'] = isLimitAmount;
  //   data['limitAmount'] = limitAmount;
  //   data['isLimitAmountName'] = isLimitAmountName;
  //   data['created_in'] = createdIn;
  //   data['created_by'] = createdBy;
  //   return data;
  // }
}
