class Product {
  final String name, description;
  final double price;
  final String image;
  Product(this.name, this.description, this.image, this.price);
  factory Product.fromJson(Map<String, dynamic> data) {
    return Product(
      data['name'],
      data['description'],
      data['image'],
      data['price'],
    );
  }
}

