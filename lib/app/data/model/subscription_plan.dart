class SubscriptionPlan {
  final int id;
  final String name;
  final String amount;
  final String currency;
  final String interval;
  final String description;

  SubscriptionPlan({
    required this.id,
    required this.name,
    required this.amount,
    required this.currency,
    required this.interval,
    required this.description,
  });

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlan(
      id: json['id'] as int,
      name: (json['name'] ?? '').toString(),
      amount: (json['amount'] ?? '').toString(),
      currency: (json['currency'] ?? '').toString(),
      interval: (json['interval'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
    );
  }

  String get currencySymbol {
    switch (currency.toUpperCase()) {
      case 'USD': return '\$';
      case 'EUR': return '€';
      case 'GBP': return '£';
      default: return '$currency ';
    }
  }

  String get displayPrice {
    final unit = name.toLowerCase().contains('month')
        ? '/Month'
        : name.toLowerCase().contains('year')
        ? '/Year'
        : '';
    return '$currencySymbol$amount$unit';
  }

  String get billedText => 'Billed $interval';
}
