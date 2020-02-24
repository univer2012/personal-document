import 'package:flutter/material.dart';

class Navi2ParamsPage extends StatelessWidget {
  final List<Product> products;
  const Navi2ParamsPage({Key key, @required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('商品列表'),),
      body: ListView.builder(itemBuilder: (context,index){
        return ListTile(
          title: Text(products[index].title),
          onTap: (){
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => new ProductDetail(product: products[index])
              )
            );
          },
        );
      }),
    );
  }
}

class Product {
  final String title;         //商品标题
  final String description;   //商品描述
  Product(this.title, this.description);
}

class ProductDetail extends StatelessWidget {
  final Product product;
  const ProductDetail({Key key, @required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${product.title}'),
      ),
      body: Center(
        child: Text('${product.description}'),
      ),
    );
  }
}