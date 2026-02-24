import 'package:flutter/foundation.dart';
import '../data/api/api_service.dart';
import '../data/model/restaurant.dart';
import 'result_state.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantSearchProvider({required this.apiService});

  ResultState<RestaurantSearchResponse> _state = const ResultStateNoData(
    'Find your favorite restaurant!',
  );
  ResultState<RestaurantSearchResponse> get state => _state;

  Future<void> searchRestaurants(String query) async {
    if (query.isEmpty) {
      _state = const ResultStateNoData('Find your favorite restaurant!');
      notifyListeners();
      return;
    }

    try {
      _state = const ResultStateLoading();
      notifyListeners();

      final response = await apiService.searchRestaurants(query);

      if (response.restaurants.isEmpty) {
        _state = const ResultStateNoData('Restaurant not found');
      } else {
        _state = ResultStateHasData(response);
      }
    } catch (e) {
      _state = const ResultStateError(
        'No Internet Connection or Failed to fetch data',
      );
    } finally {
      notifyListeners();
    }
  }
}
