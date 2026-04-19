import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String docId;
  final String image;
  final String name;
  final String price;
  final String category;
  final int stock;
  final double rating;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.docId,
    required this.image,
    required this.name,
    required this.price,
    required this.category,
    required this.stock,
    required this.rating,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: const Color(0xFFFF5252),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(2, 3),
          ),
        ],
      ),
     
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 12,
                              color: Colors.orange,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              rating.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),

                        const Spacer(),

                        
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Stok $stock",
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 10,
                                ),
                              ),
                            ),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                category,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}