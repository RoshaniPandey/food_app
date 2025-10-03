import 'package:flutter/material.dart';
import '../../bloc/order_event.dart';
import '../../bloc/order_state.dart';
import '../../models/menu_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/order_bloc.dart';

class MenuItemTile extends StatelessWidget {
  final MenuItem item;
  const MenuItemTile({super.key, required this.item, required String assetsPath});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        int qty = 0;
        if (state is RestaurantsLoaded) {
          qty = state.cart[item.id] ?? 0;
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: InkWell(
            onTap: () {
            },
            borderRadius: BorderRadius.circular(16),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              shadowColor: Colors.grey.withOpacity(0.3),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: 'menuImage-${item.id}',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          item.assetPath,
                          height: 70,
                          width: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              if (item.isSpicy ?? false)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Text(
                                    'Spicy',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            item.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),

                    // price & quantity/add buttons
                    Column(
                      children: [
                        // Price
                        if (item.discountPrice != null)
                          Column(
                            children: [
                              Text(
                                '₹${item.price.toStringAsFixed(0)}',
                                style: const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey,
                                    fontSize: 12),
                              ),
                              Text(
                                '₹${item.discountPrice!.toStringAsFixed(0)}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ],
                          )
                        else
                          Text(
                            '₹${item.price.toStringAsFixed(0)}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        const SizedBox(height: 8),
                        // Add / Quantity selector
                        qty == 0
                            ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            minimumSize: const Size(60, 32),
                          ),
                          onPressed: () => context
                              .read<OrderBloc>()
                              .add(AddItemEvent(item.id)),
                          child: const Text('Add'),
                        )
                            : AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 0),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () => context
                                    .read<OrderBloc>()
                                    .add(RemoveItemEvent(item.id)),
                                icon: const Icon(
                                  Icons.remove_circle_outline,
                                  size: 22,
                                ),
                              ),
                              Text(
                                qty.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                onPressed: () => context
                                    .read<OrderBloc>()
                                    .add(AddItemEvent(item.id)),
                                icon: const Icon(
                                  Icons.add_circle_outline,
                                  size: 22,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
