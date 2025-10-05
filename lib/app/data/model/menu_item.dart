// To parse this JSON data, do
//
//     final items = menuItemFromJson(jsonString);

import 'dart:convert';

List<MenuItem> menuItemFromJson(String str) =>
    List<MenuItem>.from(json.decode(str).map((x) => MenuItem.fromJson(x)));

String menuItemToJson(List<MenuItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MenuItem {
  final int userId;
  final String email;
  final int id;
  final String title;
  final String description;
  final String price; // API returns as string ("12.00")
  final String image; // relative path (e.g., "image/upload/..")
  final String logoImage; // full URL
  final Category category;
  final List<Modifier> modifiers;
  final DateTime createdAt;

  MenuItem({
    required this.userId,
    required this.email,
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.logoImage,
    required this.category,
    required this.modifiers,
    required this.createdAt,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
    userId: json["user_id"] ?? 0,
    email: (json["email"] ?? '').toString(),
    id: json["id"] ?? 0,
    title: (json["title"] ?? '').toString(),
    description: (json["description"] ?? '').toString(),
    price: (json["price"] ?? '0').toString(),
    image: (json["image"] ?? '').toString(),
    logoImage: (json["logo_image"] ?? '').toString(),
    category: Category.fromJson(json["category"] ?? {}),
    modifiers: (json["modifiers"] as List<dynamic>? ?? [])
        .map((e) => Modifier.fromJson(e as Map<String, dynamic>))
        .toList(),
    createdAt: DateTime.tryParse(json["created_at"] ?? '') ?? DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "email": email,
    "id": id,
    "title": title,
    "description": description,
    "price": price,
    "image": image,
    "logo_image": logoImage,
    "category": category.toJson(),
    "modifiers": List<dynamic>.from(modifiers.map((x) => x.toJson())),
    "created_at": createdAt.toIso8601String(),
  };
}

class Category {
  final int id;
  final String categoryTitle;

  Category({
    required this.id,
    required this.categoryTitle,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"] ?? 0,
    categoryTitle: (json["category_title"] ?? '').toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_title": categoryTitle,
  };
}

/// Modifier group as returned by API under "modifiers"
class Modifier {
  final String name;
  final bool isRequired;
  final List<ModifierOption> options;

  Modifier({
    required this.name,
    required this.isRequired,
    required this.options,
  });

  factory Modifier.fromJson(Map<String, dynamic> json) => Modifier(
    name: (json["name"] ?? '').toString(),
    isRequired: json["is_required"] == true,
    options: (json["options"] as List<dynamic>? ?? [])
        .map((e) => ModifierOption.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "is_required": isRequired,
    "options": List<dynamic>.from(options.map((x) => x.toJson())),
  };
}

class ModifierOption {
  final String title;
  final double? price; // maps the "Price" key (nullable == free)

  ModifierOption({
    required this.title,
    required this.price,
  });

  factory ModifierOption.fromJson(Map<String, dynamic> json) {
    // "Price" can be null / int / double
    final raw = json["Price"];
    double? parsed;
    if (raw is num) {
      parsed = raw.toDouble();
    } else {
      parsed = null;
    }
    return ModifierOption(
      title: (json["title"] ?? '').toString(),
      price: parsed,
    );
  }

  Map<String, dynamic> toJson() => {
    "title": title,
    "Price": price, // must keep capital P to match API
  };
}
