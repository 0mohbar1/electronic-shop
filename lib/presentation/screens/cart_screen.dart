import 'package:electronic_shop/bloc/cartbloc/cartbloc_bloc.dart';
import 'package:electronic_shop/presentation/widgets/drawer.dart';
import 'package:electronic_shop/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartblocBloc, CartState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            actions: [
              TextButton(
                  onPressed: () {

                    showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: Text(
                              'هل تود شراء جميع المنتجات ',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondary),
                            ),
                            content: Text(
                              '\$${state.totalPrice}: السعر ',
                              style: TextStyle(
                                fontSize: 20,
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('لا'),
                              ),
                              TextButton(
                                onPressed: () {
                                  BlocProvider.of<CartblocBloc>(context)
                                      .add(BuyAllItem());
                                  Navigator.of(context).pop();
                                },
                                child: const Text('نعم'),
                              ),
                            ],
                          );
                        });
                  },
                  child: Text(
                    'شراء الكل',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.background),
                  ))
            ],
            centerTitle: true,
            backgroundColor: ThemeProvider.primColor,
            title: Text(
              "منتجاتي",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.background,
                  fontWeight: FontWeight.bold),
            ),
            leading: Container(),
          ),
          body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 0.50,
              //  mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              final product = state.products[index];
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: ThemeProvider.myColor,
                    elevation: 2,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Display image at the top
                          Container(
                            width: double.infinity, // Take full width
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'http://192.168.92.77/TechShop/public/${product.product.image!}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Product title
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                product.product.name!,
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                              ),
                              Text(
                                '${state.products[index].quantity.toString()}x',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          // Product price
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                '\$${product.product.price.toString()}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    print(state.totalPrice);
                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        double dis = (product.product.price! *
                                                product.quantity) *
                                            (product.product.discount! / 100);
                                        return AlertDialog(
                                          title: Text(
                                            'هل انت متاكد من شراء المنتج',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondary),
                                          ),
                                          content: Text(
                                            '\$${(product.product.price! * product.quantity) - dis}: السعر ',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondary,
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('لا'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                print(
                                                    'Dispatching BuyOneItem event for product id: ${product.product.id}');

                                                BlocProvider.of<CartblocBloc>(
                                                        context)
                                                    .add(BuyOneItem(
                                                        product.product.id));
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('نعم'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: Icon(
                                    Icons.shopping_cart_outlined,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ))
                            ],
                          ),

                          // Add to cart button
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          // drawer: const AppDrawer(),
        );
      },
    );
  }
}
