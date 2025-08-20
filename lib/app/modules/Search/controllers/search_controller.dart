import 'dart:convert';

import 'package:get/get.dart';
import 'package:quopon/app/data/api.dart';
import 'package:quopon/app/data/base_client.dart';
import 'package:quopon/app/data/model/searches.dart';

class SearchController extends GetxController {
  var frequentSearches = <FrequentSearches>[].obs;
  
  Future<void> fetchFrequentSearches() async {
    try {
      final response = await BaseClient.getRequest(api: Api.frequentSearch);
      
      final decodedResponse = json.decode(response.body);
      
      if (decodedResponse != null && decodedResponse is List) {
        frequentSearches.value = decodedResponse
            .map((frequentSearchesJson) => FrequentSearches.fromJson(frequentSearchesJson))
            .toList();
      } else {
        print('No frequent searches found or incorrect response format.');
      }
    } catch (e) {
      print('Error fetching frequent searches: $e');
      // Handle error appropriately (e.g., show a Snackbar or error message)
    }
  }

  Future<void> fetchRecentSearches() async {
    try {
      final response = await BaseClient.getRequest(api: Api.frequentSearch);

      final decodedResponse = json.decode(response.body);

      if (decodedResponse != null && decodedResponse is List) {
        frequentSearches.value = decodedResponse
            .map((frequentSearchesJson) => FrequentSearches.fromJson(frequentSearchesJson))
            .toList();
      } else {
        print('No frequent searches found or incorrect response format.');
      }
    } catch (e) {
      print('Error fetching frequent searches: $e');
      // Handle error appropriately (e.g., show a Snackbar or error message)
    }
  }
  
  @override
  void onInit() {
    super.onInit();
    fetchFrequentSearches();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
