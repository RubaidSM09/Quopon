class NearShops {
  final int id;
  final String name;
  final String categoryName;
  final String description;
  final String shopTitle;
  final String? logoUrl;
  final String? coverImageUrl;
  final String rating;
  final String deliveryFee;
  final int deliveryTimeMinutes;
  final String distanceMiles;
  final bool isBeyondNeighborhood;
  final bool hasOffers;
  final int priceRange;
  final bool isPremium;
  final String statusText;

  NearShops({
    required this.id,
    required this.name,
    required this.categoryName,
    required this.description,
    required this.shopTitle,
    required this.logoUrl,
    required this.coverImageUrl,
    required this.rating,
    required this.deliveryFee,
    required this.deliveryTimeMinutes,
    required this.distanceMiles,
    required this.isBeyondNeighborhood,
    required this.hasOffers,
    required this.priceRange,
    required this.isPremium,
    required this.statusText,
  });

  // Factory constructor to create a Category object from JSON response
  factory NearShops.fromJson(Map<String, dynamic> json) {
    return NearShops(
      id: json['id'],
      name: json['name'],
      categoryName: json['category_name'],
      description: json['description'],
      shopTitle: (json['shop_title'] ?? json['shop title'] ?? '') as String,
      logoUrl: (json['shop_logo_url'] ?? json['shop logo url'] ?? '') as String,
      coverImageUrl: (json['cover_image_url'] ?? json['cover image url'] ?? '') as String,
      rating: json['rating'],
      deliveryFee: json['delivery_fee'],
      deliveryTimeMinutes: json['delivery_time_minutes'],
      distanceMiles: json['distance_miles'],
      isBeyondNeighborhood: json['is_beyond_neighborhood'],
      hasOffers: json['has_offers'],
      priceRange: json['price_range'],
      isPremium: json['is_premium'],
      statusText: json['status_text'],
    );
  }
}