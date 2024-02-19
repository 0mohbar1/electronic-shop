import 'package:electronic_shop/bloc/authbloc/authbloc_bloc.dart';
import 'package:electronic_shop/data/repository/shopping_repository.dart';
import 'package:electronic_shop/data/web_services/shopping_web_services.dart';
import 'package:electronic_shop/main.dart';
import 'package:electronic_shop/presentation/screens/auth_screen.dart';
import 'package:electronic_shop/presentation/screens/cart_screen.dart';
import 'package:electronic_shop/presentation/screens/product_overview_screen.dart';
import 'package:electronic_shop/presentation/screens/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/cartbloc/cartbloc_bloc.dart';
import 'bloc/showproductbloc/showproduct_bloc.dart';
import 'constants/strings.dart';
import 'data/models/apishopping.dart';
import 'presentation/screens/product_detail_screen.dart';

class AppRouter {
  late StoreShoppingRepository storeShoppingRepository;
  late ShowProductBloc showProductBloc;

  AppRouter() {
    storeShoppingRepository =
        StoreShoppingRepository(StoreShoppingWebServices());
    showProductBloc = ShowProductBloc(storeShoppingRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case auth_screen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) => AuthblocBloc(),
                  child: const AuthScreen(),
                ));

      case Product_overview_screen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => CartblocBloc(storeShoppingRepository),
            child: BlocProvider(
              create: (BuildContext context) =>
                  ShowProductBloc(storeShoppingRepository),
              child: const ProductOverviewScreen(), //ProductDetailScreen(),));
            ),
          ),
        );
      case Product_detail_screen:
        final ApiShopping product = settings.arguments as ApiShopping;

        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) =>
                      ShowProductBloc(storeShoppingRepository),
                  child: ProductDetailScreen(product: product),
                ));
      case Cart_Screen:
        return MaterialPageRoute(builder: (_) => const CartScreen());

      case User_screen:
        return MaterialPageRoute(builder: (_) =>  UserScreen());
    }
  }
}
