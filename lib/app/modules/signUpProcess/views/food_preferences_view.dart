import 'package:flutter/material.dart';
import 'package:quopon/common/customTextButton.dart';
import 'package:quopon/common/red_button.dart';

class FoodPreferencesScreen extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const FoodPreferencesScreen({super.key, required this.onNext, required this.onSkip});

  @override
  _FoodPreferencesScreenState createState() => _FoodPreferencesScreenState();
}

class _FoodPreferencesScreenState extends State<FoodPreferencesScreen> {
  List<String> selectedCategories = [];

  final List<FoodCategory> categories = [
    FoodCategory('Coffee & Cafes', 'assets/images/foodPreference/image 2.png', false),
    FoodCategory('Burgers & Fast Food', 'assets/images/foodPreference/image 3.png', false),
    FoodCategory('Fine Dining', 'assets/images/foodPreference/image 5.png', false),
    FoodCategory('Healthy Eats', 'assets/images/foodPreference/image 6.png', false),
    FoodCategory('BBQ & Grilled', 'assets/images/foodPreference/image 8.png', false),
    FoodCategory('Smoothies & Juices', 'assets/images/foodPreference/image 10.png', false),
    FoodCategory('Vegan & Vegetarian', 'assets/images/foodPreference/image 4.png', false),
    FoodCategory('Local Favorites', 'assets/images/foodPreference/image 11.png', false),
    FoodCategory('Street Food', 'assets/images/foodPreference/image 13.png', false),
    FoodCategory('Asian Cuisine', 'assets/images/foodPreference/image 12.png', false),
    FoodCategory('Pizza & Pasta', 'assets/images/foodPreference/image 9.png', false),
    FoodCategory('Breakfast & Brunch', 'assets/images/foodPreference/image 7.png', false),
    FoodCategory('Desserts & Bakeries', 'assets/images/foodPreference/image 1.png', false),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Tell Us What You Love',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Choose your favorite food categories so we can show you the most relevant deals around you.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 30),
          Expanded(
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: categories.map((category) {
                bool isSelected = selectedCategories.contains(category.name) || category.isDefaultSelected;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (selectedCategories.contains(category.name)) {
                        selectedCategories.remove(category.name);
                      } else {
                        selectedCategories.add(category.name);
                      }
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? Color(0xFFD62828) : Colors.grey[100],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          category.icon,
                          height: 16,
                          width: 16,
                          //color: isSelected ? Colors.white : Colors.grey[600],
                        ),
                        SizedBox(width: 8),
                        Text(
                          category.name,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class FoodCategory {
  final String name;
  final String icon;
  final bool isDefaultSelected;

  FoodCategory(this.name, this.icon, this.isDefaultSelected);
}