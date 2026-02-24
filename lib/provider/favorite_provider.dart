import 'package:flutter/foundation.dart';
import '../data/db/database_helper.dart';
import '../data/model/restaurant.dart';
import 'result_state.dart';

class FavoriteProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  FavoriteProvider({required this.databaseHelper}) {
    _getFavorites();
  }

  ResultState<List<Restaurant>> _state = const ResultStateLoading();
  ResultState<List<Restaurant>> get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> _getFavorites() async {
    _state = const ResultStateLoading();
    notifyListeners();
    try {
      final favorites = await databaseHelper.getFavorites();
      if (favorites.isNotEmpty) {
        _state = ResultStateHasData(favorites);
      } else {
        _state = const ResultStateNoData(
          'You don\'t have any favorite restaurant yet',
        );
      }
    } catch (e) {
      _state = ResultStateError('Error: $e');
    }
    notifyListeners();
  }

  Future<void> addFavorite(Restaurant restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      _getFavorites();
    } catch (e) {
      _message = 'Failed to add favorite';
      notifyListeners();
    }
  }

  Future<void> removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorites();
    } catch (e) {
      _message = 'Failed to remove favorite';
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String id) async {
    final favorite = await databaseHelper.getFavoriteById(id);
    return favorite != null;
  }

  bool isFavorited(String id) {
    if (_state is ResultStateHasData<List<Restaurant>>) {
      final items = (_state as ResultStateHasData<List<Restaurant>>).data;
      return items.any((r) => r.id == id);
    }
    return false;
  }
}
