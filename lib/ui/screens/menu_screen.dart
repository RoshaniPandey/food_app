import 'package:flutter/material.dart';
import 'package:food_app/ui/screens/cart_screen.dart';
import '../../models/restaurant.dart';
import '../widgets/menu_item_tile.dart';

class MenuScreen extends StatefulWidget {
  final Restaurant restaurant;
  const MenuScreen({super.key, required this.restaurant, required assetPath});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int cartCount = 2;
  double cartTotal = 120;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                expandedHeight: 220,
                floating: false,
                pinned: true,
                elevation: 0,
                backgroundColor: Colors.red.shade100,
                centerTitle: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    widget.restaurant.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        widget.restaurant.assetPath,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.6),
                              Colors.transparent
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 16,
                        child: Row(
                          children: [
                            const Icon(Icons.star,
                                color: Colors.amber, size: 18),
                            const SizedBox(width: 4),
                            Text(
                              "4.5  •  30 mins  •  ${widget.restaurant.menu.length} items",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined),
                    color: Colors.white,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CartScreen()),
                    ),
                  )
                ],
              ),
            ],
            body: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final item = widget.restaurant.menu[index];
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 4,
                  shadowColor: Colors.grey.withOpacity(0.2),
                  child: MenuItemTile(
                    item: item,
                    assetsPath: widget.restaurant.assetPath,
                  ),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemCount: widget.restaurant.menu.length,
            ),
          ),
          if (cartCount > 0)
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 6,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CartScreen()),
                  );
                },
                child: Text(
                  "View Cart • ₹${cartTotal.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
