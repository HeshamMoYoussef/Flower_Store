class Item {
  String imgPath;
  double price;
  String location;
  String name;

  Item({
    required this.imgPath,
    required this.name,
    required this.price,
    this.location = 'Main Branch',
  });
}

final List<Item> items = [
  Item(
    name: "product 1",
    price: 120.99,
    imgPath: "assets/img/1.webp",
    location: "First Shop",
  ),
  Item(name: "product 2", price: 212.99, imgPath: "assets/img/2.webp"),
  Item(name: "product 3", price: 125.99, imgPath: "assets/img/3.webp"),
  Item(name: "product 4", price: 152.99, imgPath: "assets/img/4.webp"),
  Item(name: "product 5", price: 172.99, imgPath: "assets/img/5.webp"),
  Item(name: "product 6", price: 142.99, imgPath: "assets/img/6.webp"),
  Item(name: "product 7", price: 162.99, imgPath: "assets/img/7.webp"),
  Item(name: "product 8", price: 192.99, imgPath: "assets/img/8.webp"),
  Item(
    name: "product 1",
    price: 126.99,
    imgPath: "assets/img/2.webp",
    location: "Second Shop",
  ),
  Item(name: "product 1", price: 172.99, imgPath: "assets/img/1.webp"),
  Item(name: "product 2", price: 102.99, imgPath: "assets/img/2.webp"),
  Item(name: "product 3", price: 152.99, imgPath: "assets/img/3.webp"),
  Item(name: "product 4", price: 123.99, imgPath: "assets/img/4.webp"),
  Item(name: "product 5", price: 126.99, imgPath: "assets/img/5.webp"),
  Item(name: "product 6", price: 152.99, imgPath: "assets/img/6.webp"),
  Item(name: "product 7", price: 142.99, imgPath: "assets/img/7.webp"),
  Item(name: "product 8", price: 182.99, imgPath: "assets/img/8.webp"),
  Item(
    name: "product1",
    price: 127.99,
    imgPath: "assets/img/2.webp",
    location: "Third Shop",
  ),
  Item(name: "product 1", price: 142.99, imgPath: "assets/img/1.webp"),
  Item(name: "product 2", price: 105.99, imgPath: "assets/img/2.webp"),
  Item(name: "product 3", price: 145.99, imgPath: "assets/img/3.webp"),
  Item(name: "product 4", price: 142.99, imgPath: "assets/img/4.webp"),
  Item(name: "product 5", price: 442.99, imgPath: "assets/img/5.webp"),
  Item(name: "product 6", price: 142.99, imgPath: "assets/img/6.webp"),
  Item(name: "product 7", price: 152.99, imgPath: "assets/img/7.webp"),
  Item(name: "product 8", price: 172.99, imgPath: "assets/img/8.webp"),
];
