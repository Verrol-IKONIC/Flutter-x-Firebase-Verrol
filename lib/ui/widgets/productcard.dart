import 'package:flutter/material.dart';
import 'package:flutter_bloc_practice/models/models.dart';
import 'package:flutter_bloc_practice/ui/pages/pages.dart';
import 'package:intl/intl.dart';

class ProductCard extends StatelessWidget {
  final Products product;
  ProductCard({this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        contentPadding: EdgeInsets.all(20),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetailPage(product: product),
                  settings: RouteSettings(arguments: product)));
        },
        title: Text(
          product.name,
          style: TextStyle(fontSize: 25),
        ),
        subtitle: Text(
          NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
              .format(double.tryParse(product.price)),
          style: TextStyle(fontSize: 20),
        ),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(product.image),
          radius: 50,
        ),
        trailing: Icon(Icons.remove_red_eye),
        onLongPress: () {},
      ),
    );
  }
}
