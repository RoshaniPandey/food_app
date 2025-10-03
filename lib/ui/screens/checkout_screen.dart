import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../bloc/order_bloc.dart';
import '../../bloc/order_event.dart';
import '../../bloc/order_state.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key, required double subtotal, required double discount, required double total});

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Stack(
        alignment: Alignment.center,
        children: [
          Lottie.asset(
            'assets/success confetti.json',
            repeat: false,
            height: 300,
            width: 300,
          ),
          AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text("🎉 Order Placed"),
            content: const Text("Your order was placed successfully. Thank you!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // close dialog
                  Navigator.pop(context); // back to home
                },
                child: const Text("OK"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController addressController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.red.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<OrderBloc, OrderState>(
          listener: (context, state) {
            if (state is RestaurantsLoaded && state.orderSuccess) {
              _showSuccessDialog(context);
            }
          },
          builder: (context, state) {
            double total = 158;

            bool isPlacing = false;
            String? orderError;

            if (state is RestaurantsLoaded) {
              isPlacing = state.isPlacing;
              orderError = state.orderError;
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Customer Details
                  _buildCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Customer Details',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 12),
                        TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                              labelText: 'Name',
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                              labelText: 'Phone No',
                              prefixIcon: Icon(Icons.phone),
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: addressController,
                          maxLines: 2,
                          decoration: const InputDecoration(
                              labelText: 'Delivery Address',
                              prefixIcon: Icon(Icons.location_on),
                              border: OutlineInputBorder()),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // order summary
                  _buildCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Order Summary',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('Masala Dosa x2'),
                            Text('₹198'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('Gulab Jamun x2'),
                            Text('₹118'),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            Text('₹$total',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // payment options
                  _buildCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Payment',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            _paymentOption('Cash on Delivery', Icons.money),
                            _paymentOption('UPI', Icons.account_balance),
                            _paymentOption('Card', Icons.credit_card),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // place order button
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade100,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: isPlacing
                          ? null
                          : () {
                        context.read<OrderBloc>().add(PlaceOrderEvent());
                      },
                      child: isPlacing
                          ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                          : const Text('Place Order',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                  ),

                  if (orderError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        orderError!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // card widget
  Widget _buildCard({required Widget child}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      shadowColor: Colors.grey.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }

  // payment option widget
  Widget _paymentOption(String label, IconData icon) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.red.shade100, size: 18),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
