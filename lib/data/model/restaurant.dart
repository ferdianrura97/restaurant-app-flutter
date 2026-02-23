class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json['id'],
        name: json['name'],
        description: json['description'] ?? '',
        pictureId: json['pictureId'],
        city: json['city'],
        rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      );
}

class RestaurantListResponse {
  final bool error;
  final String message;
  final int count;
  final List<Restaurant> restaurants;

  RestaurantListResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantListResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantListResponse(
        error: json['error'],
        message: json['message'] ?? '',
        count: json['count'] ?? 0,
        restaurants: List<Restaurant>.from(
            (json['restaurants'] as List).map((x) => Restaurant.fromJson(x))),
      );
}

class RestaurantSearchResponse {
  final bool error;
  final int founded;
  final List<Restaurant> restaurants;

  RestaurantSearchResponse({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory RestaurantSearchResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantSearchResponse(
        error: json['error'],
        founded: json['founded'] ?? 0,
        restaurants: List<Restaurant>.from(
            (json['restaurants'] as List).map((x) => Restaurant.fromJson(x))),
      );
}
