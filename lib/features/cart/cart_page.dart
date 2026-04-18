import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Keranjang",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Color(0xFFFF4040),
      ),

      body: cart.items.isEmpty
          ? const Center(child: Text("Keranjang masih kosong"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final product = cart.items[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: ListTile(
                          leading: Image.network(
                            product.image,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(product.name),
                          subtitle: Text("Rp ${product.price}"),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              cart.removeFromCart(product);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(blurRadius: 5, color: Colors.black12),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total:",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Rp ${cart.totalPrice}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Checkout berhasil!"),
                              ),
                            );

                            cart.clearCart();
                          },
                          child: const Text("Checkout"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
