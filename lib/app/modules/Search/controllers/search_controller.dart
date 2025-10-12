// lib/app/modules/Search/controllers/search_controller.dart
import 'dart:convert';

import 'package:get/get.dart';
import 'package:quopon/app/data/base_client.dart';
import 'package:quopon/app/data/model/searches.dart';

import '../../../data/api.dart';

class SearchController extends GetxController {
  // OLD (keep if used elsewhere)
  var frequentSearches = <FrequentSearches>[].obs;

  // NEW: top 5 most frequent queries (display texts)
  final frequentTop5 = <String>[].obs;

  // Existing: recent user searches
  final recentSearches = <SearchHistory>[].obs;

  // -------------------- NEW --------------------
  /// GET /auth/all-search-history/ → compute counts and take top 5
  Future<void> fetchFrequentFromHistory() async {
    try {
      final headers = await BaseClient.authHeaders();
      headers['ngrok-skip-browser-warning'] = 'true';

      final res = await BaseClient.getRequest(
        api: 'http://10.10.13.99:8090/auth/all-search-history/',
        headers: headers,
      );

      final decoded = json.decode(res.body);
      if (decoded is! List) {
        frequentTop5.clear();
        return;
      }

      // Count by normalized query (case-insensitive, trimmed)
      final Map<String, int> counts = {};
      // Preserve a nice display version for each normalized key
      final Map<String, String> display = {};

      for (final e in decoded) {
        if (e is! Map<String, dynamic>) continue;
        final raw = (e['query'] ?? '').toString();
        final norm = raw.trim().toLowerCase();
        if (norm.isEmpty) continue;

        counts[norm] = (counts[norm] ?? 0) + 1;

        // Keep the first seen non-empty display text
        display.putIfAbsent(norm, () => raw.trim());
      }

      // Sort by count desc, then alphabetically for stability
      final sorted = counts.entries.toList()
        ..sort((a, b) {
          final byCount = b.value.compareTo(a.value);
          if (byCount != 0) return byCount;
          return a.key.compareTo(b.key);
        });

      // Take top 5 and map to display strings
      final top5 = sorted.take(5).map((e) => display[e.key] ?? e.key).toList();
      frequentTop5.assignAll(top5);
    } catch (e) {
      frequentTop5.clear();
    }
  }
  // ------------------ END NEW -------------------

  Future<void> fetchFrequentSearches() async {
    // You can keep this if other screens still hit Api.frequentSearch.
    // Otherwise, you may remove it. We’ll rely on fetchFrequentFromHistory().
    try {
      final response = await BaseClient.getRequest(api: Api.frequentSearch);
      final decoded = json.decode(response.body);
      if (decoded is List) {
        frequentSearches.value =
            decoded.map((e) => FrequentSearches.fromJson(e)).toList();
      }
    } catch (_) {}
  }

  /// GET /auth/search-history/ → latest 5
  Future<void> fetchRecentSearches() async {
    try {
      final headers = await BaseClient.authHeaders();
      headers['ngrok-skip-browser-warning'] = 'true';

      final res = await BaseClient.getRequest(
        api: 'http://10.10.13.99:8090/auth/search-history/',
        headers: headers,
      );
      final decoded = json.decode(res.body);

      if (decoded is List) {
        final list = decoded
            .whereType<Map<String, dynamic>>()
            .map((e) => SearchHistory.fromJson(e))
            .toList()
          ..sort((a, b) => b.searchedAt.compareTo(a.searchedAt));
        recentSearches.assignAll(list.take(5));
      } else {
        recentSearches.clear();
      }
    } catch (_) {
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
        api: 'http://10.10.13.99:8090/auth/search-history/',
        body: json.encode({"query": query.trim()}),
        headers: headers,
      );
      // Refresh both recent and frequent after adding a new query
      await Future.wait([
        fetchRecentSearches(),
        fetchFrequentFromHistory(),
      ]);
    } catch (_) {}
  }

  @override
  void onInit() {
    super.onInit();
    // Optional: keep if still used elsewhere
    // fetchFrequentSearches();

    // Use the new frequent-from-history computation
    fetchFrequentFromHistory();
    fetchRecentSearches();
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
