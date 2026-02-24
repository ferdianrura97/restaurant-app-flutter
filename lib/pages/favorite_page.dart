import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/model/restaurant.dart';
import '../provider/favorite_provider.dart';
import '../provider/result_state.dart';
import '../common/constants.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Restaurants')),
      body: Consumer<FavoriteProvider>(
        builder: (context, provider, _) {
          final state = provider.state;
          if (state is ResultStateLoading<List<Restaurant>>) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ResultStateHasData<List<Restaurant>>) {
            return ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                var restaurant = state.data[index];
                return _buildRestaurantItem(context, restaurant, provider);
              },
            );
          } else if (state is ResultStateNoData<List<Restaurant>>) {
            return Center(child: Text(state.message));
          } else if (state is ResultStateError<List<Restaurant>>) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 50, color: Colors.red),
                  const SizedBox(height: 10),
                  Text(state.error, textAlign: TextAlign.center),
                ],
              ),
            );
          } else {
            return const Center(child: Text(''));
          }
        },
      ),
    );
  }

  Widget _buildRestaurantItem(
    BuildContext context,
    Restaurant restaurant,
    FavoriteProvider provider,
  ) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/restaurantDetailPage',
          arguments: restaurant.id,
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: '${restaurant.pictureId}_favorite', // unique tag
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                child: Image.network(
                  '${Constants.imageSmallUrl}${restaurant.pictureId}',
                  width: 120,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const SizedBox(
                    width: 120,
                    height: 100,
                    child: Icon(Icons.error),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          restaurant.city,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          restaurant.rating.toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
