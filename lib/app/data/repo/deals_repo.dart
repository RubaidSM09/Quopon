import 'dart:convert';
import 'package:quopon/app/data/base_client.dart';

class DealsRepo {
  // TODO: update to your real endpoint
  static String dealByIdUrl(int id) =>
      'https://intensely-optimal-unicorn.ngrok-free.app/vendors/all-deals/$id/';

  static Future<Map<String, dynamic>> fetchDealRawById(int id) async {
    final headers = await BaseClient.authHeaders();
    print(dealByIdUrl(id));
    print(headers);
    final res = await BaseClient.getRequest(api: dealByIdUrl(id), headers: headers);
    print(res.statusCode);

    if (res.statusCode >= 200 && res.statusCode <= 210) {
      return json.decode(res.body) as Map<String, dynamic>;
    } else {
      final body = json.decode(res.body);
      throw body['message'] ?? 'Failed to fetch deal #$id';
    }
  }
}
