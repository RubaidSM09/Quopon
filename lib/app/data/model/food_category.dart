// lib/app/data/models/food_category.dart
class FoodCategoryModel {
  final int id;
  final String name;
  final String emoji;

  FoodCategoryModel({required this.id, required this.name, required this.emoji});

  factory FoodCategoryModel.fromJson(Map<String, dynamic> j) =>
      FoodCategoryModel(id: j['id'], name: j['name'], emoji: j['emoji'] ?? '');
}
