import 'package:electronic_shop/data/models/apishopping.dart';
import 'package:electronic_shop/presentation/screens/cart_screen.dart';
import 'package:electronic_shop/presentation/screens/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/authbloc/authbloc_bloc.dart';
import '../../bloc/cartbloc/cartbloc_bloc.dart';
import '../../constants/strings.dart';
import '../screens/auth_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.shop),
              title: const Text('Store Shop'),
              onTap: () =>
                  Navigator.of(context).pushNamed(Product_overview_screen),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text("My Product"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => BlocProvider<CartblocBloc>.value(
                      value: BlocProvider.of<CartblocBloc>(context),
                      child: const CartScreen(),
                    ),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.assignment_ind),
              title: const Text("User Information"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>  UserScreen(),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (BuildContext context) => AuthblocBloc(),
                      child: const AuthScreen(),
                    )));
              },
            )
          ],
        ),
      ),
    );
  }
}
