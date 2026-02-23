import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/restaurant_detail_provider.dart';
import '../provider/result_state.dart';
import '../common/constants.dart';
import '../data/model/restaurant_detail.dart';

class RestaurantDetailPage extends StatefulWidget {
  const RestaurantDetailPage({super.key});

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  final _nameController = TextEditingController();
  final _reviewController = TextEditingController();

  bool _isInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      final id = ModalRoute.of(context)!.settings.arguments as String;
      final provider = Provider.of<RestaurantDetailProvider>(context, listen: false);
      Future.microtask(() {
        provider.getRestaurantDetail(id);
      });
      _isInit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Detail'),
      ),
      body: Consumer<RestaurantDetailProvider>(
        builder: (context, provider, _) {
          final state = provider.state;
          if (state is ResultStateLoading<RestaurantDetailResponse>) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ResultStateHasData<RestaurantDetailResponse>) {
            final restaurant = state.data.restaurant;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                   Hero(
                    tag: restaurant.pictureId,
                    child: Image.network(
                      '${Constants.imageLargeUrl}${restaurant.pictureId}',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error, size: 100),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.location_on, color: Colors.grey, size: 20),
                            const SizedBox(width: 4),
                            Text('${restaurant.city}, ${restaurant.address}', style: const TextStyle(color: Colors.grey)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 20),
                            const SizedBox(width: 4),
                            Text(restaurant.rating.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text('Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        const SizedBox(height: 8),
                        Text(restaurant.description),
                        const SizedBox(height: 16),
                        const Text('Foods', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 40,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: restaurant.menus.foods.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                  child: Text(restaurant.menus.foods[index].name),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text('Drinks', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 40,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: restaurant.menus.drinks.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                  child: Text(restaurant.menus.drinks[index].name),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text('Reviews', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        const SizedBox(height: 8),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: restaurant.customerReviews.length,
                          itemBuilder: (context, index) {
                            final review = restaurant.customerReviews[index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 8.0),
                              child: ListTile(
                                leading: const CircleAvatar(child: Icon(Icons.person)),
                                title: Text(review.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(review.date, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                    const SizedBox(height: 4),
                                    Text(review.review),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        const Text('Add Review', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _reviewController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            labelText: 'Review',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_nameController.text.isNotEmpty && _reviewController.text.isNotEmpty) {
                                final scaffoldMessenger = ScaffoldMessenger.of(context);
                                bool success = await provider.postReview(
                                  restaurant.id, 
                                  _nameController.text, 
                                  _reviewController.text
                                );
                                if (!mounted) return;
                                if (success) {
                                  _nameController.clear();
                                  _reviewController.clear();
                                  scaffoldMessenger.showSnackBar(
                                    const SnackBar(content: Text('Review added successfully')),
                                  );
                                } else {
                                  scaffoldMessenger.showSnackBar(
                                    const SnackBar(content: Text('Failed to add review')),
                                  );
                                }
                              }
                            },
                            child: const Text('Submit Review'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ResultStateNoData<RestaurantDetailResponse>) {
            return Center(child: Text(state.message));
          } else if (state is ResultStateError<RestaurantDetailResponse>) {
             return Center(
               child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   const Icon(Icons.error_outline, size: 50, color: Colors.red),
                   const SizedBox(height: 10),
                   Text(state.error, textAlign: TextAlign.center),
                   const SizedBox(height: 10),
                   ElevatedButton(
                     onPressed: () {
                         final id = ModalRoute.of(context)!.settings.arguments as String;
                         provider.getRestaurantDetail(id);
                     }, 
                     child: const Text('Refresh')
                   )
                ],
              )
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
  
  @override
  void dispose() {
    _nameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }
}
