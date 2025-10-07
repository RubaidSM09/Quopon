import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quopon/app/data/api_client.dart';

/// Public "all-reviews" item (menu_item is an object { id, title })
class PublicReviewItem {
  final int id;
  final int menuItemId;
  final String menuTitle; // fallback-safe (will be overridden by /vendors/deals/{id})
  final String userEmail; // reviewer (customer) email
  final int rating;
  final String comment;
  final DateTime createdAt;

  PublicReviewItem({
    required this.id,
    required this.menuItemId,
    required this.menuTitle,
    required this.userEmail,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  factory PublicReviewItem.fromJson(Map<String, dynamic> j) {
    final menu = (j['menu_item'] ?? {}) as Map<String, dynamic>;
    return PublicReviewItem(
      id: (j['id'] as num).toInt(),
      menuItemId: (menu['id'] as num).toInt(),
      menuTitle: (menu['title'] ?? 'Menu item').toString(),
      userEmail: (j['user'] ?? '').toString(),
      rating: (j['rating'] as num).toInt(),
      comment: (j['comment'] ?? '').toString(),
      createdAt: DateTime.tryParse((j['created_at'] ?? '').toString())?.toLocal() ?? DateTime.now(),
    );
  }
}

/// Reply item (same as elsewhere)
class ReplyItem {
  final int id;
  final int reviewId;
  final String user; // email (vendor)
  final String comment;
  final DateTime createdAt;

  ReplyItem({
    required this.id,
    required this.reviewId,
    required this.user,
    required this.comment,
    required this.createdAt,
  });

  factory ReplyItem.fromJson(Map<String, dynamic> j) => ReplyItem(
    id: (j['id'] as num).toInt(),
    reviewId: (j['review_id'] as num).toInt(),
    user: (j['user'] ?? '').toString(),
    comment: (j['comment'] ?? '').toString(),
    createdAt: DateTime.tryParse((j['created_at'] ?? '').toString())?.toLocal() ?? DateTime.now(),
  );
}

/// Vendor profile with vendor_id so we can match current vendor
class VendorProfile {
  final int vendorId;
  final String email;
  final String name;
  final String logoUrl;

  VendorProfile({
    required this.vendorId,
    required this.email,
    required this.name,
    required this.logoUrl,
  });
}

class VendorReviewsController extends GetxController {
  final _storage = const FlutterSecureStorage();

  final isLoading = false.obs;

  /// Logged-in vendor user_id (from secure storage, key: "user_id")
  final myVendorUserId = RxnInt();

  /// All customer reviews that belong to this vendor's menu items
  final reviews = <PublicReviewItem>[].obs;

  /// Partitioned lists
  List<PublicReviewItem> get pendingReviews =>
      reviews.where((r) => (repliesByReviewId[r.id]?.isEmpty ?? true)).toList();
  List<PublicReviewItem> get approvedReviews =>
      reviews.where((r) => (repliesByReviewId[r.id]?.isNotEmpty ?? false)).toList();

  /// reviewId -> replies
  final repliesByReviewId = <int, List<ReplyItem>>{}.obs;

  /// vendorEmail -> VendorProfile
  final vendorByEmail = <String, VendorProfile>{}.obs;

  /// vendorId -> VendorProfile
  final vendorById = <int, VendorProfile>{}.obs;

  /// Cache: menuId -> owner vendor user_id
  final _menuOwnerByMenuId = <int, int>{};

  /// Cache: menuId -> image url (absolute)
  final _menuImageByMenuId = <int, String>{};

  /// Cache: menuId -> title (override from /vendors/deals/{id})
  final _menuTitleByMenuId = <int, String>{};

  /// Resolved absolute URL (handles relative cloudinary paths)
  String _resolveUrl(dynamic raw) {
    var s = (raw ?? '').toString().trim();
    if (s.isEmpty) return '';
    if (s.startsWith('http')) return s;
    if (s.startsWith('/')) s = s.substring(1);
    // Your API responses use this cloudinary account in examples
    return 'https://res.cloudinary.com/dfqklzktu/$s';
  }

  /// Expose for cards
  String cardImageForMenu(int menuId) => _menuImageByMenuId[menuId] ?? '';
  String menuTitleFor(int menuId, String fallback) => _menuTitleByMenuId[menuId] ?? fallback;

  /// Latest reply for a review
  ReplyItem? latestReplyFor(int reviewId) {
    final list = repliesByReviewId[reviewId];
    if (list == null || list.isEmpty) return null;
    list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return list.first;
  }

  /// Map reply email -> business display name + logo url
  (String display, String logo) vendorNameAndLogoForEmail(String email) {
    final v = vendorByEmail[email];
    if (v == null) return (email, '');
    final name = v.name.trim().isEmpty ? email : v.name.trim();
    return (name, v.logoUrl);
  }

  /// My vendor logo (for reply dialog avatar)
  String get myVendorLogoUrl {
    final id = myVendorUserId.value;
    if (id == null) return '';
    final v = vendorById[id];
    return v?.logoUrl ?? '';
  }

  /// “2 days”, “3 h”, etc.
  String timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inDays >= 1) return '${diff.inDays} days';
    if (diff.inHours >= 1) return '${diff.inHours} h';
    if (diff.inMinutes >= 1) return '${diff.inMinutes} min';
    return DateFormat('MMM d').format(dt);
  }

  @override
  void onInit() {
    super.onInit();
    fetchAll();
  }

  Future<void> fetchAll() async {
    isLoading.value = true;
    try {
      await _loadMyVendorUserId();
      await _fetchVendorsIndex();          // email -> business name/logo (+vendorId map)
      await _fetchAndFilterReviewsForMe(); // fills `reviews` and fetches menu image/title
      await Future.wait(reviews.map((r) => _fetchReplies(r.id)));
    } catch (e, st) {
      debugPrint('VendorReviewsController.fetchAll error: $e\n$st');
      Get.snackbar('Error', 'Failed to load vendor reviews');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _loadMyVendorUserId() async {
    final raw = await _storage.read(key: 'user_id');
    if (raw != null && raw.trim().isNotEmpty) {
      myVendorUserId.value = int.tryParse(raw.trim());
    }
    if (myVendorUserId.value == null) {
      throw Exception('Missing user_id in secure storage');
    }
  }

  Future<void> _fetchVendorsIndex() async {
    try {
      final res = await ApiClient.get('/vendors/all-business-profile/');
      if (res.statusCode == 200) {
        final data = json.decode(res.body) as List;
        final byEmail = <String, VendorProfile>{};
        final byId = <int, VendorProfile>{};
        for (final e in data) {
          final m = e as Map<String, dynamic>;
          final email = (m['vendor_email'] ?? '').toString();
          final vendorId = (m['vendor_id'] as num?)?.toInt() ?? -1;
          if (email.isEmpty || vendorId <= 0) continue;
          final logoRaw = (m['logo_image'] ?? '').toString();
          final logo = _resolveUrl(logoRaw);
          final profile = VendorProfile(
            vendorId: vendorId,
            email: email,
            name: (m['name'] ?? '').toString(),
            logoUrl: logo,
          );
          byEmail[email] = profile;
          byId[vendorId] = profile;
        }
        vendorByEmail.assignAll(byEmail);
        vendorById.assignAll(byId);
      }
    } catch (_) {
      // ignore; will fallback to showing raw email
    }
  }

  Future<void> _fetchAndFilterReviewsForMe() async {
    reviews.clear();
    final res = await ApiClient.get('/discover/all-reviews/');
    if (res.statusCode != 200) {
      Get.snackbar('Error', 'Failed to load all reviews (${res.statusCode})');
      return;
    }
    final list = (json.decode(res.body) as List)
        .map((e) => PublicReviewItem.fromJson(e as Map<String, dynamic>))
        .toList();

    final mine = <PublicReviewItem>[];
    for (final r in list) {
      final ownerId = await _ownerVendorIdForMenu(r.menuItemId);
      if (ownerId != null && ownerId == myVendorUserId.value) {
        mine.add(r);
      }
    }
    reviews.assignAll(mine);
  }

  /// Return owner vendor user_id for a given menu item, and cache title+image too
  Future<int?> _ownerVendorIdForMenu(int menuId) async {
    if (_menuOwnerByMenuId.containsKey(menuId)) return _menuOwnerByMenuId[menuId];

    try {
      final res = await ApiClient.get('/vendors/deals/$menuId/');
      if (res.statusCode == 200) {
        final m = json.decode(res.body) as Map<String, dynamic>;
        final owner = (m['user_id'] as num?)?.toInt();

        // Title override
        final t = (m['title'] ?? '').toString();
        if (t.isNotEmpty) _menuTitleByMenuId[menuId] = t;

        // Image selection priority: logo_image (absolute) -> image (may be relative)
        final rawLogo = (m['logo_image'] ?? '').toString();
        final rawImage = (m['image'] ?? '').toString();
        final resolvedImage =
        rawLogo.toString().trim().isNotEmpty ? _resolveUrl(rawLogo) : _resolveUrl(rawImage);
        if (resolvedImage.isNotEmpty) _menuImageByMenuId[menuId] = resolvedImage;

        if (owner != null) _menuOwnerByMenuId[menuId] = owner;
        return owner;
      }
    } catch (_) {}
    return null;
  }

  Future<void> _fetchReplies(int reviewId) async {
    try {
      final res = await ApiClient.get('/discover/review/reply/$reviewId/');
      if (res.statusCode == 200) {
        final list = (json.decode(res.body) as List)
            .map((e) => ReplyItem.fromJson(e as Map<String, dynamic>))
            .toList();
        repliesByReviewId[reviewId] = list;
        repliesByReviewId.refresh();
      }
    } catch (_) {
      // no replies is fine
    }
  }

  Future<bool> postReply({
    required int reviewId,
    required String comment,
  }) async {
    try {
      final res = await ApiClient.post(
        '/discover/review/reply/create/$reviewId/',
        {"comment": comment}, // ApiClient.post jsonEncodes internally
      );
      if (res.statusCode >= 200 && res.statusCode < 300) {
        await _fetchReplies(reviewId);
        Get.snackbar('Success', 'Reply submitted');
        return true;
      }
      Get.snackbar('Error', 'Failed to submit reply (${res.statusCode})');
    } catch (e) {
      Get.snackbar('Network', 'Could not submit reply: $e');
    }
    return false;
  }
}
