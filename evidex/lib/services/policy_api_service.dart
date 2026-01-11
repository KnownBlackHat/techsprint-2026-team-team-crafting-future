import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/policy_model.dart';

class PolicyApiService {
  static const String _baseUrl =
      'http://10.10.147.195:8000/api/v1/policy';

  static Future<List<PolicyModel>> fetchPolicies(String state) async {
    final url = Uri.parse('$_baseUrl/$state');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        print('Policy API Response: $data');
        return data
            .map((e) => PolicyModel.fromJson(e))
            .toList();
      } else {
        throw Exception(
            'Failed to load policies (${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Error fetching policies: $e');
    }
  }
}
