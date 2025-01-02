import 'package:flutter/material.dart';

void main() {
  runApp(FoodOrderApp());
}

class FoodOrderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '點餐系統',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: MenuPage(),
    );
  }
}

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final List<Map<String, dynamic>> menu = [
    {'name': '炒飯', 'price': 100},
    {'name': '牛肉麵', 'price': 150},
    {'name': '珍珠奶茶', 'price': 50},
    {'name': '雞排', 'price': 80},
    {'name': '滷肉飯', 'price': 70},
  ];

  final List<Map<String, dynamic>> cart = [];

  void addToCart(Map<String, dynamic> item) {
    setState(() {
      cart.add(item);
    });
  }

  void navigateToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(cart: cart),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('菜單'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: navigateToCart,
          )
        ],
      ),
      body: ListView.builder(
        itemCount: menu.length,
        itemBuilder: (context, index) {
          final item = menu[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(item['name']),
              subtitle: Text('價格：\$${item['price']}'),
              trailing: ElevatedButton(
                onPressed: () => addToCart(item),
                child: Text('加入購物車'),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final List<Map<String, dynamic>> cart;

  CartPage({required this.cart});

  @override
  Widget build(BuildContext context) {
    double total = cart.fold(0, (sum, item) => sum + item['price']);

    return Scaffold(
      appBar: AppBar(title: Text('購物車')),
      body: cart.isEmpty
          ? Center(child: Text('購物車是空的！'))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final item = cart[index];
                return ListTile(
                  title: Text(item['name']),
                  subtitle: Text('價格：\$${item['price']}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '總價：\$${total.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
