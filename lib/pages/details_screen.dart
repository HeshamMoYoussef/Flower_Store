import 'package:flower_app/shared/appbar.dart';
import 'package:flower_app/shared/constants.dart';
import 'package:flower_app/shared/item.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final Item product;

  const Details({super.key, required this.product});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool _isShowMore = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [ProductAndPrice()],
        backgroundColor: appBarGreen,
        title: const Text("Details screen"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(widget.product.imgPath),
            const SizedBox(height: 11),
            Text(
              "\$ ${widget.product.price}",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 129, 129),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              "New",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          // SizedBox(
                          //   width: 8,
                          // ),
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 26,
                                  color: Color.fromARGB(255, 255, 191, 0),
                                ),
                                Icon(
                                  Icons.star,
                                  size: 26,
                                  color: Color.fromARGB(255, 255, 191, 0),
                                ),
                                Icon(
                                  Icons.star,
                                  size: 26,
                                  color: Color.fromARGB(255, 255, 191, 0),
                                ),
                                Icon(
                                  Icons.star,
                                  size: 26,
                                  color: Color.fromARGB(255, 255, 191, 0),
                                ),
                                Icon(
                                  Icons.star,
                                  size: 26,
                                  color: Color.fromARGB(255, 255, 191, 0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.edit_location,
                            size: 26,
                            color: Color.fromARGB(168, 3, 65, 27),
                            // color: Color.fromARGB(255, 186, 30, 30),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            widget.product.location,
                            style: const TextStyle(fontSize: 19),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Details : ",
                      style: TextStyle(fontSize: 22),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "A flower, sometimes known as a bloom or blossom, is the reproductive structure found in flowering plants (plants of the division Angiospermae). The biological function of a flower is to facilitate reproduction, usually by providing a mechanism for the union of sperm with eggs. Flowers may facilitate outcrossing (fusion of sperm and eggs from different individuals in a population) resulting from cross-pollination or allow selfing (fusion of sperm and egg from the same flower) when self-pollination occurs.",
                    style: const TextStyle(fontSize: 18),
                    maxLines: _isShowMore ? 3 : null,
                    overflow: TextOverflow.fade,
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isShowMore = !_isShowMore;
                });
              },
              child: Text(
                _isShowMore ? "Show more" : "Show less",
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
