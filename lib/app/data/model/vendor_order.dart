// lib/app/data/models/vendor_order.dart
class VendorOrderItem {
  final String name;
  final int qty;

  VendorOrderItem({required this.name, required this.qty});

  factory VendorOrderItem.fromJson(Map<String, dynamic> j) => VendorOrderItem(
    name: (j['item_name'] ?? '').toString(),
    qty: j['quantity'] is int
        ? j['quantity'] as int
        : int.tryParse('${j['quantity']}') ?? 0,
  );
}

class VendorOrder {
  final String id;               // order_id (uuid)
  final String status;           // API status (e.g., PENDING_PAYMENT, PREPARING, ...)
  final String orderType;        // DELIVERY / PICKUP (may come via delivery_type OR order_type)
  final String note;             // note
  final String createdAt;        // ISO string
  final String totalAmount;      // string from API
  final List<VendorOrderItem> items;

  VendorOrder({
    required this.id,
    required this.status,
    required this.orderType,
    required this.note,
    required this.createdAt,
    required this.totalAmount,
    required this.items,
  });

  factory VendorOrder.fromJson(Map<String, dynamic> j) {
    final itemsList = (j['items'] as List? ?? [])
        .map((e) => VendorOrderItem.fromJson(e as Map<String, dynamic>))
        .toList();

    // Some payloads use delivery_type vs order_type; prefer DELIVERY/PICKUP if present.
    final dt = (j['delivery_type'] ?? '').toString().toUpperCase();
    final ot = (j['order_type'] ?? '').toString().toUpperCase();
    final mode = (dt == 'DELIVERY' || ot == 'DELIVERY') ? 'DELIVERY' : 'PICKUP';

    return VendorOrder(
      id: (j['order_id'] ?? '').toString(),
      status: (j['status'] ?? '').toString().toUpperCase(),
      orderType: mode,
      note: (j['note'] ?? '').toString(),
      createdAt: (j['created_at'] ?? '').toString(),
      totalAmount: (j['total_amount'] ?? '0').toString(),
      items: itemsList,
    );
  }
}
