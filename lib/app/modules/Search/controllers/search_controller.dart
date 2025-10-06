import 'dart:convert';

import 'package:get/get.dart';
import 'package:quopon/app/data/api.dart';
import 'package:quopon/app/data/base_client.dart';
import 'package:quopon/app/data/model/searches.dart';

class SearchController extends GetxController {
  // already in your file
  var frequentSearches = <FrequentSearches>[].obs;

  // NEW: recent user searches
  final recentSearches = <SearchHistory>[].obs;

  Future<void> fetchFrequentSearches() async {
    try {
      final response = await BaseClient.getRequest(api: Api.frequentSearch);
      final decoded = json.decode(response.body);
      if (decoded is List) {
        frequentSearches.value =
            decoded.map((e) => FrequentSearches.fromJson(e)).toList();
      }
    } catch (e) {
      // ignore
    }
  }

  /// GET /auth/search-history/ → latest 5 (sorted by searched_at desc)
  Future<void> fetchRecentSearches() async {
    try {
      final headers = await BaseClient.authHeaders();
      headers['ngrok-skip-browser-warning'] = 'true';

      final res = await BaseClient.getRequest(api: 'https://intensely-optimal-unicorn.ngrok-free.app/auth/search-history/', headers: headers);
      final decoded = json.decode(res.body);

      if (decoded is List) {
        final list = decoded
            .whereType<Map<String, dynamic>>()
            .map((e) => SearchHistory.fromJson(e))
            .toList();

        list.sort((a, b) => b.searchedAt.compareTo(a.searchedAt));
        recentSearches.assignAll(list.take(5));
      } else {
        recentSearches.clear();
      }
    } catch (e) {
      recentSearches.clear();
    }
  }

  /// POST /auth/search-history/ { "query": "..." }
  Future<void> addSearchToHistory(String query) async {
    if (query.trim().isEmpty) return;
    try {
      final headers = await BaseClient.authHeaders();
      headers['Content-Type'] = 'application/json';
      headers['ngrok-skip-browser-warning'] = 'true';

      await BaseClient.postRequest(
        api: 'https://intensely-optimal-unicorn.ngrok-free.app/auth/search-history/',
        body: json.encode({"query": query.trim()}),
        headers: headers,
      );
      // refresh list so UI updates immediately
      await fetchRecentSearches();
    } catch (_) {
      // silent fail
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchFrequentSearches();
    fetchRecentSearches(); // load recent on screen open
  }
}

// lib/app/data/model/search_history.dart
class SearchHistory {
  final int id;
  final int user;
  final String query;
  final DateTime searchedAt;

  SearchHistory({
    required this.id,
    required this.user,
    required this.query,
    required this.searchedAt,
  });

  factory SearchHistory.fromJson(Map<String, dynamic> json) => SearchHistory(
    id: json['id'] ?? 0,
    user: json['user'] ?? 0,
    query: (json['query'] ?? '').toString(),
    searchedAt: DateTime.tryParse(json['searched_at'] ?? '') ?? DateTime.now(),
  );
}
