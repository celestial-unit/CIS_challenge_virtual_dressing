import 'dart:convert';
import 'package:http/http.dart' as http;
import 'clothing_item.dart';

class ClothingService {
  static const String apiUrl = 'http://localhost:5000/api/catalog';

  Future<List<ClothingItem>> fetchClothingItems() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => ClothingItem.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load clothing items');
      }
    } catch (e) {
      throw Exception('Failed to load clothing items: $e');
    }
  }
}
