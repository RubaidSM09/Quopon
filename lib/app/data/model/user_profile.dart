class UserProfile {
  final String email;
  final String fullName;
  final String phoneNumber;
  final String profilePictureUrl;
  final String country;
  final String city;
  final String address;
  final String subscriptionStatus;

  UserProfile({
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    required this.profilePictureUrl,
    required this.country,
    required this.city,
    required this.address,
    required this.subscriptionStatus,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    email: (json['email'] ?? '').toString(),
    fullName: (json['full_name'] ?? '').toString(),
    phoneNumber: (json['phone_number'] ?? '').toString(),
    profilePictureUrl: (json['profile_picture_url'] ?? '').toString(),
    country: (json['country'] ?? '').toString(),
    city: (json['city'] ?? '').toString(),
    address: (json['address'] ?? '').toString(),
    subscriptionStatus: (json['subscription_status'] ?? '').toString(),
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "full_name": fullName,
    "phone_number": phoneNumber,
    "profile_picture": profilePictureUrl,
    "country": country,
    "city": city,
    "address": address,
  };
}
