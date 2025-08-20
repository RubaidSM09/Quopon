class FrequentSearches {
  final String queryText;
  final int totalSearches;

  FrequentSearches({
    required this.queryText,
    required this.totalSearches
  });

  // Factory constructor to create a Category object from JSON response
  factory FrequentSearches.fromJson(Map<String, dynamic> json) {
    return FrequentSearches(
      queryText: json['query_text'],
      totalSearches: json['total_searches'],
    );
  }
}

class RecentSearches {
  final String queryText;
  final int totalSearches;

  RecentSearches({
    required this.queryText,
    required this.totalSearches
  });

  // Factory constructor to create a Category object from JSON response
  factory RecentSearches.fromJson(Map<String, dynamic> json) {
    return RecentSearches(
      queryText: json['query_text'],
      totalSearches: json['total_searches'],
    );
  }
}