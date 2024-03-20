import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/product.dart';

List<Product> parseProduct(String respond) {
  final List<Map<String, dynamic>> parsedList =
      List<Map<String, dynamic>>.from(json.decode(respond));
  return parsedList.map((json) => Product.fromJson(json)).toList();
}

Future<List<Product>> fetchProduct() async {
  final response = await http
      .get(Uri.parse('http://yourIP/JsonWebsever/product.json'));
  if (response.statusCode == 200) {
    return parseProduct(response.body);
  } else {
    throw Exception('Failed to load products');
  }
}

class RestApi extends StatelessWidget {
  final Future<List<Product>> products;
  final String title;
  const RestApi({super.key, required this.products, required this.title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: FutureBuilder<List<Product>>(
          future: products,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return snapshot.hasData
                  ? ProductBox(items: snapshot.data!)
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            }
          },
        ),
      ),
    );
  }
}

class ProductBox extends StatelessWidget {
  final List<Product> items;
  const ProductBox({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductPage(
                  item: items[index],
                ),
              ),
            );
          },
          child: ListTile(
            leading: Image.network(
              items[index].image,
              width: 100,
              height: 100,
              fit: BoxFit.fitHeight,
            ),
            title: Text(items[index].name),
            subtitle: Text(items[index].description),
          ),
        );
      },
    );
  }
}

class ProductPage extends StatelessWidget {
  final Product item;
  const ProductPage({super.key, required this.item});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
              height: 200,
              width: 200,
              child: Image.network(item.image),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Description:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(item.description),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Price: \$${item.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
