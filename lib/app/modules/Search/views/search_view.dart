import 'package:flutter/material.dart' hide SearchController;

import 'package:get/get.dart';
import 'package:quopon/common/customTextButton.dart';
import 'package:quopon/common/red_button.dart';

import '../controllers/search_controller.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  // final TextEditingController _searchController = TextEditingController(text: "Downtown");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Row(
                children: [
                  Icon(Icons.arrow_back),
                  SizedBox(width: 8),
                  Text(
                    "Search",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        readOnly: true, // <<— prevent actual editing and avoid focus issues
                        decoration: InputDecoration(
                          hintText: 'Downtown',
                          hintStyle: TextStyle(color: Color(0xFF6F7E8D)),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Icon(Icons.search, color: Colors.grey[500]),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            Image.asset(
              'assets/images/Search/No Deals.png', // ensure this asset exists
              height: 200,
            ),
            const SizedBox(height: 24),
            const Text(
              'No Deals Found Nearby',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12),
              child: Text(
                'Try exploring nearby cities or check out trending deals from other locations.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            // const Spacer(),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  GradientButton(text: "Browse Popular Deals", onPressed: () { }, colors: [Color(0xFFF4F5F6), Color(0xFFEEF0F3)], textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Color(0xFF020711)),),
                  const SizedBox(height: 12),
                  RedButton(buttonText: 'Explore Nearby Cities', onPressed: () { }),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}