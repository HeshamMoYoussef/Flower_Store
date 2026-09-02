// ignore_for_file: prefer_const_constructors

import 'package:flower_app/pages/check_out.dart';
import 'package:flower_app/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductAndPrice extends StatelessWidget {
  const ProductAndPrice({super.key});

  @override
  Widget build(BuildContext context) {
    final cartInstance = Provider.of<Cart>(context);

    return Row(
      children: [
        Stack(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Color.fromARGB(211, 164, 255, 193),
                shape: BoxShape.circle,
              ),
              child: Text(
                '${cartInstance.itemCount}',
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CheckOut()),
                );
              },
              icon: Icon(Icons.add_shopping_cart),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Text("\$ ${cartInstance.price}"),
        ),
      ],
    );
  }
}
