import 'package:flutter/foundation.dart';
import '../data/api/api_service.dart';
import '../data/model/restaurant_detail.dart';
import 'result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantDetailProvider({required this.apiService});

  ResultState<RestaurantDetailResponse> _state = const ResultStateLoading();
  ResultState<RestaurantDetailResponse> get state => _state;

  Future<void> getRestaurantDetail(String id) async {
    try {
      _state = const ResultStateLoading();
      notifyListeners();

      final response = await apiService.getRestaurantDetail(id);
      _state = ResultStateHasData(response);
    } catch (e) {
      _state = const ResultStateError(
        'No Internet Connection or Failed to fetch data',
      );
    } finally {
      notifyListeners();
    }
  }

  Future<bool> postReview(String id, String name, String review) async {
    try {
      final response = await apiService.postReview(id, name, review);
      if (!response.error) {
        await getRestaurantDetail(id);
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Failed to post review: $e");
      return false;
    }
  }
}
