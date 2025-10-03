import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../../bloc/order_bloc.dart';
import '../../bloc/order_event.dart';
import '../../bloc/order_state.dart';
import '../widgets/restaurant_card.dart';
import 'cart_screen.dart';
import '../../models/restaurant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = '';
  String selectedCategory = 'All';
  bool vegOnly = false;
  bool nonVegOnly = false;
  String sortByRating = 'None';
  double minPrice = 0;
  double maxPrice = 500;

  final List<String> categories = [
    'All',
    'Pizza',
    'Indian',
    'Chinese',
    'Desserts'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Restaurants'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () => _showFilterDialog(),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                context.read<OrderBloc>().add(LoadRestaurantsEvent()),
          ),

          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () =>
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (__) => const CartScreen()),
                ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildFilterChips(),
          Expanded(
            child: BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                if (state is RestaurantsLoading || state is OrderInitial) {
                  return _buildShimmerLoading();
                } else if (state is RestaurantsLoadFailure) {
                  return _buildErrorScreen(state.message);
                } else if (state is RestaurantsLoaded) {
                  // Apply search & filter
                  final filteredRestaurants = state.restaurants.where((r) {
                    final matchesSearch = r.name.toLowerCase().contains(
                        searchQuery.toLowerCase());
                    final matchesCategory = selectedCategory == 'All' || r
                        .category == selectedCategory;
                    return matchesSearch && matchesCategory;
                  }).toList();

                  if (filteredRestaurants.isEmpty) {
                    return const Center(child: Text('No restaurants found'));
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<OrderBloc>().add(LoadRestaurantsEvent());
                    },
                    child: ListView(
                      padding: const EdgeInsets.all(12),
                      children: [
                        _buildPopularSection(filteredRestaurants, state),
                        const SizedBox(height: 12),
                        ...filteredRestaurants.map((r) =>
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: RestaurantCard(restaurant: r),
                            )),
                      ],
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search restaurants...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        onChanged: (value) {
          setState(() {
            searchQuery = value;
          });
        },
      ),
    );
  }
  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: categories.map((category) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(category),
              selected: selectedCategory == category,
              onSelected: (selected) {
                setState(() {
                  selectedCategory = category;
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }
  Widget _buildPopularSection(List<Restaurant> restaurants,
      RestaurantsLoaded state) {
    // collect all popular items from restaurants
    final allPopular = restaurants
        .expand((r) => r.popularItems)
        .take(10)
        .toList();

    if (allPopular.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Text(
              "Popular Near You",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              itemBuilder: (context, index) {
                final item = allPopular[index];

                int quantity = 0;
                if (state is RestaurantsLoaded) {
                  quantity = state.cart[item.id] ?? 0;
                }

                return Container(
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(2, 2)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12)),
                          child: Image.asset(item.assetPath, fit: BoxFit.cover,
                              width: double.infinity),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.name, maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.w500)),
                            Text("₹${item.price.toStringAsFixed(0)}",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 6),
                            quantity == 0
                                ? SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  context.read<OrderBloc>().add(
                                      AddItemEvent(item.id));
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 6),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text("Add"),
                              ),
                            )
                                : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    context.read<OrderBloc>().add(
                                        RemoveItemEvent(item.id));
                                  },
                                  icon: const Icon(
                                      Icons.remove_circle, color: Colors.red),
                                ),
                                Text(quantity.toString(),
                                    style: const TextStyle(fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                IconButton(
                                  onPressed: () {
                                    context.read<OrderBloc>().add(
                                        AddItemEvent(item.id));
                                  },
                                  icon: const Icon(
                                      Icons.add_circle, color: Colors.green),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemCount: allPopular.length,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: 5,
        itemBuilder: (_, _) =>
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
      ),
    );
  }
  Widget _buildErrorScreen(String message) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, size: 80, color: Colors.redAccent),
          const SizedBox(height: 12),
          Text(
            'Oops! Something went wrong.\n$message',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () =>
                context.read<OrderBloc>().add(LoadRestaurantsEvent()),
            icon: const Icon(Icons.refresh),
            label: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Filters", style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Checkbox(
                        value: vegOnly,
                        onChanged: (val) {
                          setSheetState(() => vegOnly = val!);
                          setState(() {});
                        },
                      ),
                      const Text("Veg Only"),
                      const SizedBox(width: 20),
                      Checkbox(
                        value: nonVegOnly,
                        onChanged: (val) {
                          setSheetState(() => nonVegOnly = val!);
                          setState(() {});
                        },
                      ),
                      const Text("Non-Veg Only"),
                    ],
                  ),

                  DropdownButton<String>(
                    value: sortByRating,
                    onChanged: (val) {
                      setSheetState(() => sortByRating = val!);
                      setState(() {});
                    },
                    items: const [
                      DropdownMenuItem(
                          value: 'None', child: Text("No Sorting")),
                      DropdownMenuItem(value: 'HighToLow',
                          child: Text("Rating: High → Low")),
                      DropdownMenuItem(value: 'LowToHigh',
                          child: Text("Rating: Low → High")),
                    ],
                  ),

                  const SizedBox(height: 12),
                  const Text("Price Range"),

                  RangeSlider(
                    values: RangeValues(minPrice, maxPrice),
                    min: 0,
                    max: 500,
                    divisions: 10,
                    labels: RangeLabels(
                        '₹${minPrice.toInt()}', '₹${maxPrice.toInt()}'),
                    onChanged: (values) {
                      setSheetState(() {
                        minPrice = values.start;
                        maxPrice = values.end;
                      });
                      setState(() {});
                    },
                  ),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Apply Filters"),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
  }
