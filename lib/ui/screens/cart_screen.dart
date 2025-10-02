import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/order_bloc.dart';
import 'package:food_app/bloc/order_state.dart';

import '../../bloc/order_event.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _promoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.pink[100],
        elevation: 0,
        title: const Text(
          "Your Cart",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is RestaurantsLoaded) {
            final cart = state.cart;
            final restaurants = state.restaurants;

            // Cart items
            final cartItems = cart.entries
                .where((entry) => entry.value > 0)
                .map((entry) {
              final item = restaurants
                  .expand((r) => r.menu)
                  .firstWhere((menuItem) => menuItem.id == entry.key);
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(item.assetPath,
                        width: 50, height: 50, fit: BoxFit.cover),
                  ),
                  title: Text(item.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  subtitle: Text("₹${item.price}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          context.read<OrderBloc>().add(RemoveItemEvent(item.id));
                        },
                      ),
                      Text("${entry.value}"),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () {
                          context.read<OrderBloc>().add(AddItemEvent(item.id));
                        },
                      ),
                    ],
                  ),
                ),
              );
            }).toList();

            double subtotal = 0;
            cart.forEach((itemId, qty) {
              final item = restaurants
                  .expand((r) => r.menu)
                  .firstWhere((menuItem) => menuItem.id == itemId);
              subtotal += item.price * qty;
            });

            double discount = state.discount;
            double total = subtotal - discount;

            return Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      ...cartItems,
                      const SizedBox(height: 12),

                      // Promo code box
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _promoController,
                                decoration: InputDecoration(
                                  hintText: "Enter Promo Code",
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.check_circle,
                                  color: Colors.purple),
                              onPressed: () {
                                context.read<OrderBloc>().add(
                                  ApplyPromoEvent(_promoController.text),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, -2))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Total: ₹${total.toStringAsFixed(0)}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),

                      const SizedBox(height: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink[200],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CheckoutScreen(
                                subtotal: subtotal,
                                discount: discount,
                                total: total,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          "Proceed to Checkout",
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Center(
                        child: TextButton(
                          onPressed: () {
                            context.read<OrderBloc>().add(ClearCartEvent());
                          },
                          child: const Text("Clear Cart",
                              style: TextStyle(color: Colors.purple)),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
