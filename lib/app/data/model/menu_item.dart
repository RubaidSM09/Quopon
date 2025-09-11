// To parse this JSON data, do
//
//     final menuItem = menuItemFromJson(jsonString);

import 'dart:convert';

List<MenuItem> menuItemFromJson(String str) => List<MenuItem>.from(json.decode(str).map((x) => MenuItem.fromJson(x)));

String menuItemToJson(List<MenuItem> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MenuItem {
  int userId;
  int user;
  String email;
  int id;
  String title;
  String description;
  String price;
  String image;
  String logoImage;
  Category category;
  List<ModifierGroup> modifierGroups; // List of ModifierGroup objects instead of List<int>
  DateTime createdAt;

  MenuItem({
    required this.userId,
    required this.user,
    required this.email,
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.logoImage,
    required this.category,
    required this.modifierGroups,
    required this.createdAt,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
    userId: json["user_id"],
    user: json["user"],
    email: json["email"],
    id: json["id"],
    title: json["title"],
    description: json["description"],
    price: json["price"],
    image: json["image"],
    logoImage: json["logo_image"],
    category: Category.fromJson(json["category"]),
    modifierGroups: List<ModifierGroup>.from(json["modifier_groups"].map((x) => ModifierGroup.fromJson(x))), // Modify here
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user": user,
    "email": email,
    "id": id,
    "title": title,
    "description": description,
    "price": price,
    "image": image,
    "logo_image": logoImage,
    "category": category.toJson(),
    "modifier_groups": List<dynamic>.from(modifierGroups.map((x) => x.toJson())), // Modify here
    "created_at": createdAt.toIso8601String(),
  };
}

class Category {
  int id;
  String categoryTitle;

  Category({
    required this.id,
    required this.categoryTitle,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    categoryTitle: json["category_title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_title": categoryTitle,
  };
}

class ModifierGroup {  // New class to represent modifier group
  int id;
  String name;

  ModifierGroup({
    required this.id,
    required this.name,
  });

  factory ModifierGroup.fromJson(Map<String, dynamic> json) => ModifierGroup(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
