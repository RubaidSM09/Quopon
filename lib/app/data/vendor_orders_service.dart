// lib/app/data/services/vendor_orders_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class VendorOrdersService {
  static const _url =
      'https://doctorless-stopperless-turner.ngrok-free.dev/order/orders/vendor-orders/';

  // If you need auth, place your token logic here.
  static Future<Map<String, String>> _headers() async {
    return <String, String>{
      'Content-Type': 'application/json',
      'ngrok-skip-browser-warning': 'true',
      // 'Authorization': 'Bearer <token>', // add if your API requires it
    };
  }

  static Future<List<dynamic>> fetchRaw() async {
    final res = await http.get(Uri.parse(_url), headers: await _headers());
    if (res.statusCode != 200) {
      throw Exception('Failed to fetch orders (${res.statusCode})');
    }
    final decoded = json.decode(res.body);
    if (decoded is! List) throw Exception('Unexpected response shape');
    return decoded;
  }
}
