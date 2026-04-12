import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<Map<String, dynamic>> products = const [
    {
      "name": "Beras Premium 5kg",
      "price": 75000,
      "image": "https://via.placeholder.com/150",
    },
    {
      "name": "Minyak Goreng 1L",
      "price": 18000,
      "image": "https://via.placeholder.com/150",
    },
    {
      "name": "Gula Pasir 1kg",
      "price": 14000,
      "image": "https://via.placeholder.com/150",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Marketplace Sembako")),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) {
          final item = products[index];

          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(item["image"], height: 100, fit: BoxFit.cover),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    item["name"],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text("Rp ${item["price"]}"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
