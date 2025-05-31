import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcartapp/cart_page.dart';
import 'package:shoppingcartapp/cart_cubit.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  final List<Map<String, dynamic>> items = const [
    {"name": "Item 1", "price": 100},
    {"name": "Item 2", "price": 200},
    {"name": "Item 3", "price": 300},
    {"name": "Item 4", "price": 400},
    {"name": "Item 5", "price": 500},
    {"name": "Item 6", "price": 600},
    {"name": "Item 7", "price": 700},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Shopping Cart App'),
        backgroundColor: Colors.blue,
        // actions: [
        //   BlocBuilder<CartCubit, List<Map<String, dynamic>>>(
        //     builder: (context, cartItems) {
        //       return Padding(
        //         padding: const EdgeInsets.only(right: 16.0),
        //         child: Center(child: Text('Cart: ${cartItems.length}')),
        //       );
        //     },
        //   ),
        // ],
      ),
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(items[index]['name']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(items[index]['price'].toString()),
                    IconButton(
                      icon: const Icon(Icons.add_shopping_cart),
                      onPressed: () {
                        context.read<CartCubit>().addToCart(items[index]);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('${items[index]['name']} added to cart'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
            child: const Text('Go to Cart'),
          ),
        ],
      ),
    );
  }
}
