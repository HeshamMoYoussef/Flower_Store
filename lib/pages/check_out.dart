import 'package:flower_app/pages/details_screen.dart';
import 'package:flower_app/provider/cart_provider.dart';
import 'package:flower_app/shared/appbar.dart';
import 'package:flower_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({super.key});

  @override
  Widget build(BuildContext context) {
    final cartInstance = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Check Out"),
        backgroundColor: appBarGreen,
        actions: const [ProductAndPrice()],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: cartInstance.itemCount,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    // horizontalTitleGap: 25,

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Details(
                            product: cartInstance.selectedProducts[index],
                          ),
                        ),
                      );
                    },
                    title: Text(cartInstance.selectedProducts[index].name),
                    subtitle: Text(
                      '${cartInstance.selectedProducts[index].price} - ${cartInstance.selectedProducts[index].location}',
                    ),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                        cartInstance.selectedProducts[index].imgPath,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        cartInstance.delete(
                          cartInstance.selectedProducts[index],
                        );
                      },
                      icon: const Icon(Icons.remove),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30, top: 30),
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(btnPink),
                padding: WidgetStateProperty.all(const EdgeInsets.all(15)),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              child: Text(
                "Pay \$${cartInstance.price}",
                style: const TextStyle(fontSize: 19),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
