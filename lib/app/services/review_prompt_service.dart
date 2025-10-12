import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// Very small persistent store without extra packages.
/// Replace with GetStorage/SharedPreferences later if you prefer.
class _MemoryStore {
  static const _k = 'review_prompts_v1';
  static late GetStorage _box;

  static Future<void> init() async {
    await GetStorage.init();
    _box = GetStorage();
  }

  static Future<Map<String, dynamic>> read() async {
    final v = _box.read(_k);
    if (v is Map) return Map<String, dynamic>.from(v);
    return {};
  }

  static Future<void> write(Map<String, dynamic> data) async {
    await _box.write(_k, data);
  }
}

/// Model we persist per order
class _Prompt {
  final String orderId;
  final String menuName;
  final DateTime dueAt;   // show at/after
  bool shown;

  _Prompt({required this.orderId, required this.menuName, required this.dueAt, this.shown = false});

  Map<String, dynamic> toJson() => {
    'orderId': orderId,
    'menuName': menuName,
    'dueAt': dueAt.toIso8601String(),
    'shown': shown,
  };

  static _Prompt? fromJson(Map<String, dynamic>? j) {
    if (j == null) return null;
    final due = DateTime.tryParse((j['dueAt'] ?? '').toString());
    if (due == null) return null;
    return _Prompt(
      orderId: (j['orderId'] ?? '').toString(),
      menuName: (j['menuName'] ?? '').toString(),
      dueAt: due,
      shown: j['shown'] == true,
    );
  }
}

/// Queue-style service that can pop a Review dialog from anywhere.
class ReviewPromptService extends GetxService with WidgetsBindingObserver {
  static ReviewPromptService get to => Get.find<ReviewPromptService>();

  final Map<String, _Prompt> _pending = {}; // key = orderId
  Timer? _tick;
  bool _isShowing = false;

  Future<ReviewPromptService> init() async {
    WidgetsBinding.instance.addObserver(this);
    await _MemoryStore.init();
    await _load();
    _startTicker();
    // Immediate check in case app opened after due time.
    _checkAndShow();
    return this;
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    _tick?.cancel();
    super.onClose();
  }

  // Called from TrackOrderController when finished
  Future<void> scheduleReview({
    required String orderId,
    required String menuName,
    DateTime? deliveredAt,
  }) async {
    // If already scheduled/shown, ignore
    final existing = _pending[orderId];
    if (existing != null) return;

    final now = DateTime.now();
    final due = (deliveredAt ?? now).add(const Duration(hours: 2));
    _pending[orderId] = _Prompt(orderId: orderId, menuName: menuName, dueAt: due, shown: false);
    await _save();
  }

  // Show when due (only once per order)
  Future<void> _checkAndShow() async {
    if (_isShowing) return;
    final now = DateTime.now();

    // Find any earliest due, not shown
    final dueList = _pending.values
        .where((p) => !p.shown && p.dueAt.isBefore(now.add(const Duration(seconds: 1))))
        .toList();

    if (dueList.isEmpty) return;

    // FIFO by due time
    dueList.sort((a, b) => a.dueAt.compareTo(b.dueAt));
    final prompt = dueList.first;

    // try to show
    _isShowing = true;
    try {
      await _showReviewDialog(prompt.menuName);
      prompt.shown = true;
      await _save();
    } finally {
      _isShowing = false;
    }
  }

  // Try to get an overlay context and show the dialog from anywhere
  Future<void> _showReviewDialog(String menuName) async {
    // make sure we have a context to show over
    final ctx = Get.overlayContext ?? Get.context;
    if (ctx == null) {
      await Future.delayed(const Duration(milliseconds: 300));
      return _showReviewDialog(menuName);
    }

    // Build the dialog via the builder we registered in main.dart
    final builder = Get.find<Widget Function(String)>(tag: 'ReviewViewBuilder');
    await Get.dialog(builder(menuName), barrierDismissible: true);
  }

  void _startTicker() {
    _tick?.cancel();
    // every 15 seconds is light and good enough
    _tick = Timer.periodic(const Duration(seconds: 15), (_) => _checkAndShow());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkAndShow();
    }
  }

  Future<void> _save() async {
    final map = <String, dynamic>{};
    _pending.forEach((key, p) => map[key] = p.toJson());
    await _MemoryStore.write(map);
  }

  Future<void> _load() async {
    final raw = await _MemoryStore.read();
    _pending.clear();
    raw.forEach((key, value) {
      final p = _Prompt.fromJson((value is Map) ? value.cast<String, dynamic>() : null);
      if (p != null) _pending[key] = p;
    });
  }
}

/// Thin wrapper widget that builds your existing ReviewView
/// without importing it at the top of the file to avoid cycles.
class _ReviewDialogEntry extends StatelessWidget {
  final String menuName;
  const _ReviewDialogEntry({required this.menuName});

  @override
  Widget build(BuildContext context) {
    // Import here at usage site (you can move this file if you prefer).
    // If your project structure makes this awkward, simply import normally
    // at the top of this file — just ensure there’s no circular import.
    return _buildRealDialog(menuName);
  }

  Widget _buildRealDialog(String name) {
    // Replace direct import with a closure to the actual ReviewView:
    // If your ReviewView is exactly as in your snippet:
    return Get.find<Widget Function(String)>(tag: 'ReviewViewBuilder')(name);
  }
}
