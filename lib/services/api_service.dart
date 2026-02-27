import 'dart:convert';
import 'package:api_app/models/ipo_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<IPOItem>> fetchIPOItems() async {
    final response = await http.get(
      Uri.parse('https://jainam-uat.ipoplus.in/api/GetWebIPOes'),
    );
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => IPOItem.fromJson(e)).toList();
    } else {
      throw Exception("Failed to Load Ipo Data");
    }
  }
}
