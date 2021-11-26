final String tableInventory = 'inventory';

class Inventory {
  final int? inventoryID;
  final String inventoryTitle;
  final String inventoryCategory;
  final int inventoryQuantity;
  final String inventoryMeasure;

  const Inventory(
      {this.inventoryID,
      required this.inventoryTitle,
      required this.inventoryCategory,
      required this.inventoryQuantity,
      required this.inventoryMeasure});

  Map<String, Object?> toJson() => {
        InventoryFields.inventoryID: inventoryID,
        InventoryFields.inventoryTitle: inventoryTitle,
        InventoryFields.inventoryCategory: inventoryCategory,
        InventoryFields.inventoryQuantity: inventoryQuantity,
        InventoryFields.inventoryMeasure: inventoryMeasure
      };

  Inventory copy(
          {int? inventoryID,
          String? inventoryTitle,
          String? inventoryCategory,
          int? inventoryQuantity,
          String? inventoryMeasure}) =>
      Inventory(
          inventoryID: inventoryID ?? this.inventoryID,
          inventoryTitle: inventoryTitle ?? this.inventoryTitle,
          inventoryCategory: inventoryCategory ?? this.inventoryCategory,
          inventoryQuantity: inventoryQuantity ?? this.inventoryQuantity,
          inventoryMeasure: inventoryMeasure ?? this.inventoryMeasure);

  static Inventory fromJson(Map<String, Object?> json) => Inventory(
      inventoryID: json[InventoryFields.inventoryID] as int?,
      inventoryTitle: json[InventoryFields.inventoryTitle] as String,
      inventoryCategory: json[InventoryFields.inventoryCategory] as String,
      inventoryQuantity: json[InventoryFields.inventoryQuantity] as int,
      inventoryMeasure: json[InventoryFields.inventoryMeasure] as String);
}

class InventoryFields {
  static final List<String> values = [
    inventoryID,
    inventoryTitle,
    inventoryCategory,
    inventoryQuantity,
    inventoryMeasure
  ];
  static final String inventoryID = '_inventoryID';
  static final String inventoryTitle = 'inventoryTitle';
  static final String inventoryCategory = 'inventoryCategory';
  static final String inventoryQuantity = 'inventoryQuantity';
  static final String inventoryMeasure = 'inventoryMeasure';
}
