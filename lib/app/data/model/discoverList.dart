class DiscoverList {
  final int id;
  final String name;
  final String rating;
  final int reviewCount;
  final String distanceKm;
  final String tags;
  final int discountPercentage;
  final String logoUrl;

  DiscoverList({
    required this.id,
    required this.name,
    required this.rating,
    required this.reviewCount,
    required this.distanceKm,
    required this.tags,
    required this.discountPercentage,
    required this.logoUrl,
  });

  // Factory constructor to create a Category object from JSON response
  factory DiscoverList.fromJson(Map<String, dynamic> json) {
    return DiscoverList(
      id: json['id'],
      name: json['name'],
      rating: json['rating'],
      reviewCount: json['review_count'],
      distanceKm: json['distance_km'],
      tags: json['tags'],
      discountPercentage: json['discount_percentage'],
      logoUrl: json['logo_url'],
    );
  }
}