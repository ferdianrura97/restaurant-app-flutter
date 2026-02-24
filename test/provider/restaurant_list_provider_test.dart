import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/restaurant_list_provider.dart';
import 'package:restaurant_app/provider/result_state.dart';

import 'restaurant_list_provider_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  group('RestaurantListProvider Unit Tests', () {
    test('1. Initial state should be ResultStateLoading', () {
       final mockApiService = MockApiService();
       when(mockApiService.getRestaurantList()).thenAnswer((_) async {
         await Future.delayed(const Duration(milliseconds: 100));
         return RestaurantListResponse(error: false, message: 'success', count: 0, restaurants: []);
       });
       // Since the constructor calls fetchAllRestaurant() which executes asynchronously,
       // the synchronous state immediately after instantiation should be Loading.
       final provider = RestaurantListProvider(apiService: mockApiService);
       expect(provider.state, isA<ResultStateLoading>());
    });

    test('2. Should return ResultStateHasData when API call is successful', () async {
      final mockApiService = MockApiService();
      final mockResponse = RestaurantListResponse(
        error: false,
        message: 'success',
        count: 1,
        restaurants: [
          Restaurant(id: '1', name: 'Test', description: 'desc', pictureId: 'pic', city: 'City', rating: 4.5)
        ]
      );

      when(mockApiService.getRestaurantList()).thenAnswer((_) async => mockResponse);
      final provider = RestaurantListProvider(apiService: mockApiService);

      // Call it explicitly to await completion
      await provider.fetchAllRestaurant();

      expect(provider.state, isA<ResultStateHasData<RestaurantListResponse>>());
      final stateData = provider.state as ResultStateHasData<RestaurantListResponse>;
      expect(stateData.data.restaurants.length, 1);
      expect(stateData.data.restaurants.first.name, 'Test');
    });

    test('3. Should return ResultStateError when API call fails', () async {
      final mockApiService = MockApiService();
      when(mockApiService.getRestaurantList()).thenThrow(Exception('Failed to connect to network'));
      final provider = RestaurantListProvider(apiService: mockApiService);

      await provider.fetchAllRestaurant();

      expect(provider.state, isA<ResultStateError>());
      final stateData = provider.state as ResultStateError;
      expect(stateData.error, 'No Internet Connection or Failed to fetch data');
    });
  });
}
