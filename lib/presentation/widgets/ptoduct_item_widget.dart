import 'package:electronic_shop/bloc/favoritebloc/favorite_bloc.dart';
import 'package:electronic_shop/bloc/showproductbloc/showproduct_bloc.dart';
import 'package:electronic_shop/presentation/screens/product_detail_screen.dart';
import 'package:electronic_shop/providers/favorite_provider.dart';
import 'package:electronic_shop/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../bloc/cartbloc/cartbloc_bloc.dart';
import '../../data/models/apishopping.dart';

class ProductItemWidget extends StatefulWidget {
  final ApiShopping product;
  final int index;

  ProductItemWidget({Key? key, required this.product, required this.index})
      : super(key: key);

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavoriteProvider>(context);
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductDetailScreen(
                product: widget.product,
              ))),
      child: Hero(
        tag: widget.product.id!,
        child: SingleChildScrollView(
          child: Card(
            color: ThemeProvider.myColor,
            elevation: 2,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                        image: NetworkImage(widget.product.image!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Product title
                  Text(
                    widget.product.title!,
                    maxLines: 2,
                    style:  TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Product price
                  Text(
                    '\$${widget.product.price.toString()}',
                    style:  TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  // Add to cart button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () => BlocProvider.of<CartblocBloc>(context)
                            .add(AddtoCartEvent(product: widget.product)),
                        icon:  Icon(Icons.shopping_cart,color: Theme.of(context).colorScheme.onPrimary,),
                      ),
                      IconButton(
                        onPressed: () {
                          //  context.read<FavoriteBloc>().add(AddtoFavoriteEvent(product: product));
                          setState(() {
                            favProvider.changeFavProduct();
                          });
                          final favoriteBloc = context.read<FavoriteBloc>();
                          favoriteBloc.add(
                            favProvider.isFav
                                ? AddtoFavoriteEvent(product: widget.product)
                                : RemoveFromFavoriteEvent(
                                    id: widget.product.id!),
                          );
                          favProvider.isFav
                              ? context.read<ShowProductBloc>().add(
                                  ShowIconFavorite(
                                      index: widget.index, isFav: true))
                              : context.read<ShowProductBloc>().add(
                                  UnShowIconFavorite(
                                      index: widget.index, isFav: false));
                        },
                        icon: widget.product.isFavorite!
                            ? Icon(Icons.favorite,color: Theme.of(context).colorScheme.onPrimary,)
                            : Icon(Icons.favorite_border,color: Theme.of(context).colorScheme.onPrimary,),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
