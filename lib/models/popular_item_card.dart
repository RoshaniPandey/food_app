import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/order_bloc.dart';
import '../../models/menu_item.dart';
import '../bloc/order_event.dart';

class PopularItemCard extends StatelessWidget {
  final MenuItem item;
  final int quantity;

  const PopularItemCard({
    super.key,
    required this.item,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(item.assetPath, fit: BoxFit.cover, width: double.infinity),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: Column(
              children: [
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  "₹${item.price.toStringAsFixed(0)}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                quantity == 0
                    ? SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<OrderBloc>().add(AddItemEvent(item.id));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8),
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
                        context.read<OrderBloc>().add(RemoveItemEvent(item.id));
                      },
                      icon: const Icon(Icons.remove_circle, color: Colors.red),
                    ),
                    Text(
                      quantity.toString(),
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<OrderBloc>().add(AddItemEvent(item.id));
                      },
                      icon: const Icon(Icons.add_circle, color: Colors.green),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
