import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/restaurant.dart';
import '../model/restaurant_detail.dart';
import '../model/review_response.dart';
import '../../common/constants.dart';

class ApiService {
  Future<RestaurantListResponse> getRestaurantList() async {
    final response = await http.get(Uri.parse('${Constants.baseUrl}/list'));
    if (response.statusCode == 200) {
      return RestaurantListResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    final response = await http.get(
      Uri.parse('${Constants.baseUrl}/detail/$id'),
    );
    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }

  Future<RestaurantSearchResponse> searchRestaurants(String query) async {
    final response = await http.get(
      Uri.parse('${Constants.baseUrl}/search?q=$query'),
    );
    if (response.statusCode == 200) {
      return RestaurantSearchResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load searched restaurants');
    }
  }

  Future<ReviewResponse> postReview(
    String id,
    String name,
    String review,
  ) async {
    final response = await http.post(
      Uri.parse('${Constants.baseUrl}/review'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'id': id, 'name': name, 'review': review}),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ReviewResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post review');
    }
  }
}
