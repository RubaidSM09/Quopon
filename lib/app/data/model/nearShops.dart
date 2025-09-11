class NearShops {
  final int id;
  final int vendorId;
  final String vendorEmail;
  final String name;
  final String? logoImage;
  final String kvkNumber;
  final String phoneNumber;
  final String address;
  final int? category;

  NearShops({
    required this.id,
    required this.vendorId,
    required this.vendorEmail,
    required this.name,
    this.logoImage,
    required this.kvkNumber,
    required this.phoneNumber,
    required this.address,
    this.category,
  });

  factory NearShops.fromJson(Map<String, dynamic> json) {
    return NearShops(
      id: json['id'],
      vendorId: json['vendor_id'],
      vendorEmail: json['vendor_email'],
      name: json['name'],
      logoImage: json['logo_image'],
      kvkNumber: json['kvk_number'],
      phoneNumber: json['phone_number'],
      address: json['address'],
      category: json['category'],
    );
  }
}
