import 'package:electronic_shop/providers/theme_provider.dart';
import 'package:flutter/material.dart';

import '../../data/models/apishopping.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.background,
            ),
          ),
          centerTitle: true,
          backgroundColor: ThemeProvider.primColor,
          title: Text(
            "تفاصيل المنتج",
            style: TextStyle(
                color: Theme.of(context).colorScheme.background,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'http://192.168.92.77/TechShop/public/${product.image!}',
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Product Details
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title with decoration
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: ThemeProvider.primColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          product.name!,
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSecondary),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Price with decoration
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: ThemeProvider.primColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'السعر : \$${product.price.toString()}',
                          style:  TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'اللون : ${product.color.toString()}',
                        style:  TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),

                      const SizedBox(height: 8),
                      // Description
                      Text(
                        product.desc!,
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.onSecondary),
                      ),
                      const SizedBox(height: 8),
                      // Rating
                      Text(
                        'الحسم : %${product.discount?.toString()}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
