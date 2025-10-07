import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../data/api_client.dart';

class Review {
  final String review;
  final String reviewer;
  final String time;
  const Review({required this.review, required this.reviewer, required this.time});
}

class VendorFeedback {
  /// Can be a network URL or an asset path.
  final String image;
  final String title; // vendor display name
  final String feedback;
  final String time; // time-ago
  const VendorFeedback({
    required this.image,
    required this.title,
    required this.feedback,
    required this.time,
  });
}

class ReviewItem {
  final int id;
  final int menuItem;
  final int rating;
  final String comment;
  final DateTime createdAt;

  ReviewItem({
    required this.id,
    required this.menuItem,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  factory ReviewItem.fromJson(Map<String, dynamic> j) => ReviewItem(
    id: j['id'] as int,
    menuItem: j['menu_item'] as int,
    rating: j['rating'] as int,
    comment: (j['comment'] ?? '').toString(),
    createdAt:
    DateTime.tryParse((j['created_at'] ?? '').toString()) ?? DateTime.now(),
  );
}

class DealLite {
  final int id;
  final String title;
  final String imageUrl; // absolute: logo_image
  DealLite({required this.id, required this.title, required this.imageUrl});
}

class ReplyItem {
  final int id;
  final int reviewId;
  final String user; // email (from API)
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
    id: j['id'] as int,
    reviewId: (j['review_id'] as num).toInt(),
    user: (j['user'] ?? '').toString(),
    comment: (j['comment'] ?? '').toString(),
    createdAt:
    DateTime.tryParse((j['created_at'] ?? '').toString()) ?? DateTime.now(),
  );
}

/// Simple vendor profile for mapping reply email -> name & logo
class VendorProfile {
  final String email;
  final String name;
  final String logoUrl; // can be null/empty
  VendorProfile({required this.email, required this.name, required this.logoUrl});
}

class MyReviewsController extends GetxController {
  final isLoading = false.obs;
  final reviews = <ReviewItem>[].obs;
  final filteredReviews = <ReviewItem>[].obs; // For search results
  final searchQuery = ''.obs; // To track search input

  /// dealId -> DealLite
  final dealsById = <int, DealLite>{}.obs;

  /// reviewId -> replies list
  final repliesByReviewId = <int, List<ReplyItem>>{}.obs;

  /// vendorEmail -> VendorProfile (for replacing email with name + logo)
  final vendorByEmail = <String, VendorProfile>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAll();
    // Update filtered reviews whenever search query or reviews change
    ever(searchQuery, (_) => filterReviews());
    ever(reviews, (_) => filterReviews());
  }

  Future<void> fetchAll() async {
    isLoading.value = true;
    try {
      // Load lookup tables first (deals + vendor profiles), then reviews, then replies
      await Future.wait([
        fetchDealsIndex(),
        fetchVendorsIndex(),
      ]);

      await fetchMyReviews();

      await Future.wait(reviews.map((r) => fetchReplies(r.id)));
    } finally {
      isLoading.value = false;
    }
  }

  /// GET /discover/my-reviews/
  Future<void> fetchMyReviews() async {
    try {
      final res = await ApiClient.get('/discover/my-reviews/');
      if (res.statusCode == 200) {
        final list = (json.decode(res.body) as List)
            .map((e) => ReviewItem.fromJson(e as Map<String, dynamic>))
            .toList();
        reviews.assignAll(list);
        filterReviews(); // Update filtered reviews after fetching
      } else {
        Get.snackbar('Error', 'Failed to load reviews (${res.statusCode})');
      }
    } catch (e) {
      Get.snackbar('Network', 'Could not load reviews: $e');
    }
  }

  /// GET /vendors/deals/
  Future<void> fetchDealsIndex() async {
    try {
      final res = await ApiClient.get('/vendors/deals/');
      if (res.statusCode == 200) {
        final data = json.decode(res.body) as List;
        final map = <int, DealLite>{};
        for (final e in data) {
          final m = e as Map<String, dynamic>;
          final id = (m['id'] as num).toInt();
          final title = (m['title'] ?? '').toString();
          final img = (m['logo_image'] ?? '').toString();
          map[id] = DealLite(id: id, title: title, imageUrl: img);
        }
        dealsById.assignAll(map);
      }
    } catch (_) {
      // silent; fallback handled by getters
    }
  }

  /// GET /vendors/all-business-profile/
  /// Build email -> {name, logo}
  Future<void> fetchVendorsIndex() async {
    try {
      final res = await ApiClient.get('/vendors/all-business-profile/');
      if (res.statusCode == 200) {
        final data = json.decode(res.body) as List;
        final map = <String, VendorProfile>{};
        for (final e in data) {
          final m = e as Map<String, dynamic>;
          final email = (m['vendor_email'] ?? '').toString();
          if (email.isEmpty) continue;
          map[email] = VendorProfile(
            email: email,
            name: (m['name'] ?? '').toString(),
            logoUrl: (m['logo_image'] ?? '').toString(),
          );
        }
        vendorByEmail.assignAll(map);
      }
    } catch (_) {
      // ignore; fallback will use email
    }
  }

  /// GET /discover/review/reply/{review_id}/
  Future<void> fetchReplies(int reviewId) async {
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
      // ignore; no replies is fine
    }
  }

  /// Filter reviews based on search query
  void filterReviews() {
    final query = searchQuery.value.trim().toLowerCase();
    if (query.isEmpty) {
      filteredReviews.assignAll(reviews);
      return;
    }

    filteredReviews.assignAll(reviews.where((review) {
      final dealTitle = dealTitleFor(review.menuItem).toLowerCase();
      final comment = review.comment.toLowerCase();
      final reply = latestReplyFor(review.id);
      final vendorName = reply != null
          ? vendorNameAndLogoForEmail(reply.user).$1.toLowerCase()
          : '';

      return dealTitle.contains(query) ||
          comment.contains(query) ||
          vendorName.contains(query);
    }).toList());
  }

  /// Update search query
  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  /// “2 days”, “3 h”, etc. — compact for your card
  String timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inDays >= 1) return '${diff.inDays} days';
    if (diff.inHours >= 1) return '${diff.inHours} h';
    if (diff.inMinutes >= 1) return '${diff.inMinutes} min';
    return DateFormat('MMM d').format(dt);
  }

  String dealTitleFor(int dealId) {
    final d = dealsById[dealId];
    if (d == null || d.title.trim().isEmpty) return 'Menu item #$dealId';
    return d.title;
  }

  String dealImageFor(int dealId) {
    final d = dealsById[dealId];
    return d?.imageUrl ?? '';
  }

  /// Latest reply item, if any
  ReplyItem? latestReplyFor(int reviewId) {
    final list = repliesByReviewId[reviewId];
    if (list == null || list.isEmpty) return null;
    list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return list.first;
  }

  /// Map reply “user” (email) -> business name + logo url (fallbacks to email)
  (String displayName, String logoUrl) vendorNameAndLogoForEmail(String email) {
    final v = vendorByEmail[email];
    if (v == null) return (email, ''); // fallback to raw email, no logo
    final name = v.name.trim().isEmpty ? email : v.name.trim();
    return (name, v.logoUrl);
  }
}