import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcartapp/cart_cubit.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  double getTotal(List<Map<String, dynamic>> cartItems) {
  double total = 0;
  for (var item in cartItems) {
    if (item["price"] is num) {
      total += (item['price'] as num).toDouble();
    } else {
      String priceStr =
          item['price'].toString().replaceAll(RegExp(r'[^\d.]'), '');
      total += double.tryParse(priceStr) ?? 0.0;
    }
  }
  return total;
}

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.delete),
        //     onPressed: () {
        //       context.read<CartCubit>().clearCart();
        //       ScaffoldMessenger.of(context).showSnackBar(
        //         const SnackBar(content: Text('Cart cleared')),
        //       );
        //     },
        //   ),
        // ],
      ),
  body:    BlocBuilder<CartCubit, List<Map<String, dynamic>>>(
  builder: (context, cartItems) {
    if (cartItems.isEmpty) {
      return const Center(child: Text('Your cart is empty.'));
    }

    final total = getTotal(cartItems);

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];
              return ListTile(
                title: Text(item['name'] ?? 'Item'),
                subtitle: Text('Price: ${item['price'] ?? 0}'),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_shopping_cart),
                  onPressed: () {
                    context.read<CartCubit>().removeFromCart(index);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('${item['name']} removed from cart'),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Total: ₹${total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Checkout"),
                      content: Text(
                          "Your total is ₹${total.toStringAsFixed(2)}.\nThank you for shopping!"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Close"),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text("Checkout"),
              ),
            ],
          ),
        ),
      ],
    );
  },
)
    );
  }
}