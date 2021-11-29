final String tableBudget = 'budget';

class Budget {
  final int? budgetID;
  final String budgetName;
  final int budgetQuantity;
  final String budgetDescription;

  const Budget(
      {this.budgetID,
      required this.budgetName,
      required this.budgetQuantity,
      required this.budgetDescription});

  Map<String, Object?> toJson() => {
        BudgetFields.budgetID: budgetID,
        BudgetFields.budgetName: budgetName,
        BudgetFields.budgetQuantity: budgetQuantity,
        BudgetFields.budgetDescription: budgetDescription
      };

  Budget copy(
          {int? budgetID,
          String? budgetName,
          int? budgetQuantity,
          String? budgetDescription}) =>
      Budget(
          budgetID: budgetID ?? this.budgetID,
          budgetName: budgetName ?? this.budgetName,
          budgetQuantity: budgetQuantity ?? this.budgetQuantity,
          budgetDescription: budgetDescription ?? this.budgetDescription);

  static Budget fromJson(Map<String, Object?> json) => Budget(
      budgetID: json[BudgetFields.budgetID] as int?,
      budgetName: json[BudgetFields.budgetName] as String,
      budgetQuantity: json[BudgetFields.budgetQuantity] as int,
      budgetDescription: json[BudgetFields.budgetDescription] as String);
}

class BudgetFields {
  static final List<String> values = [
    budgetID,
    budgetName,
    budgetQuantity,
    budgetDescription
  ];

  static final String budgetID = '_budgetID';
  static final String budgetName = '_budgetName';
  static final String budgetQuantity = '_budgetQuantity';
  static final String budgetDescription = '_budgetDescription';
}
