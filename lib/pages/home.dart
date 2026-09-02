import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower_app/pages/details_screen.dart';
import 'package:flower_app/provider/cart_provider.dart';
import 'package:flower_app/provider/google_sign_in_provider.dart';
import 'package:flower_app/shared/appbar.dart';
import 'package:flower_app/shared/constants.dart';
import 'package:flower_app/shared/drawer.dart';
import 'package:flower_app/shared/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    ///////////////////// Provider ////////////
    final googleProvider = Provider.of<GoogleSignInProvider>(
      context,
      listen: false,
    );
    final cartInstance = Provider.of<Cart>(context);
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      drawer: DrawerWidget(user: user, googleProvider: googleProvider),
      appBar: AppBar(
        backgroundColor: appBarGreen,
        title: const Text("Home"),
        centerTitle: true,
        actions: const [ProductAndPrice()],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin:
                  const EdgeInsets.only(bottom: 5, top: 5, left: 10, right: 10),
              decoration: const BoxDecoration(color: Colors.white70),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 4 / 3.5,
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 10,
                ),
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                    children: [
                      Positioned(
                        top: -25,
                        bottom: -15,
                        left: 0,
                        right: 0,
                        child: GridTile(
                          footer: GridTileBar(
                            // backgroundColor: Color.fromARGB(66, 73, 127, 110),
                            trailing: IconButton(
                              color: const Color.fromARGB(255, 62, 94, 70),
                              onPressed: () {
                                cartInstance.add(items[index]);
                              },
                              icon: const Icon(Icons.add, size: 30),
                            ),

                            leading: Text(
                              "\$${items[index].price}",
                              style: const TextStyle(fontSize: 16),
                            ),

                            title: const Text(""),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Details(product: items[index]),
                                ),
                              );
                            },
                            // use ClipRRect & Positioned
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  top: 5,
                                  bottom: 0,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(1000),
                                    child: Image.asset(items[index].imgPath),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(color: appBarGreen),
            child: const SizedBox(
              height: 40,
              width: double.infinity,
              child: Center(
                child: Text(
                  'FLOWER STORE ©',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
