import 'package:flutter/foundation.dart';
import '../data/api/api_service.dart';
import '../data/model/restaurant.dart';
import 'result_state.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantListProvider({required this.apiService}) {
    fetchAllRestaurant();
  }

  ResultState<RestaurantListResponse> _state = const ResultStateLoading();
  ResultState<RestaurantListResponse> get state => _state;

  Future<void> fetchAllRestaurant() async {
    try {
      _state = const ResultStateLoading();
      notifyListeners();

      final response = await apiService.getRestaurantList();

      if (response.restaurants.isEmpty) {
        _state = const ResultStateNoData('Empty Data');
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
