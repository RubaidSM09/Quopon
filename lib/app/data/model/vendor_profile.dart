class VendorProfile {
  final int id;
  final String vendorEmail;
  final int vendorId; // <- this must match deal.user_id
  final String name;
  final String? logoImage;
  final String kvkNumber;
  final String phoneNumber;
  final String address;
  final int? category;

  VendorProfile({
    required this.id,
    required this.vendorEmail,
    required this.vendorId,
    required this.name,
    required this.logoImage,
    required this.kvkNumber,
    required this.phoneNumber,
    required this.address,
    required this.category,
  });

  factory VendorProfile.fromJson(Map<String, dynamic> json) => VendorProfile(
    id: json["id"],
    vendorEmail: json["vendor_email"] ?? "",
    vendorId: json["vendor_id"],
    name: json["name"] ?? "",
    logoImage: json["logo_image"], // may be null
    kvkNumber: json["kvk_number"] ?? "",
    phoneNumber: json["phone_number"] ?? "",
    address: json["address"] ?? "",
    category: json["category"],
  );
}
