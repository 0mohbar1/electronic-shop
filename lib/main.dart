import 'package:electronic_shop/constants/strings.dart';
import 'package:electronic_shop/data/models/apishopping.dart';
import 'package:electronic_shop/data/repository/shopping_repository.dart';
import 'package:electronic_shop/providers/favorite_provider.dart';
import 'package:electronic_shop/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_router.dart';
import 'bloc/showproductbloc/showproduct_bloc.dart';
import 'data/web_services/shopping_web_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final appRouter = AppRouter();
  final storeShoppingRepository =
      StoreShoppingRepository(StoreShoppingWebServices());
  final showProductBloc = ShowProductBloc(storeShoppingRepository);

  runApp(StoreShopping(
    appRouter: appRouter,
    storeShoppingRepository: storeShoppingRepository,
    showProductBloc: showProductBloc,
    preferences: prefs,
  ));
}

class StoreShopping extends StatelessWidget {
  final AppRouter appRouter;
  final StoreShoppingRepository storeShoppingRepository;
  final ShowProductBloc showProductBloc;
  final SharedPreferences preferences;

  const StoreShopping({
    Key? key,
    required this.appRouter,
    required this.storeShoppingRepository,
    required this.showProductBloc,
    required this.preferences,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
      child: MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_)=>FavoriteProvider())
        ],
        child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
          return MaterialApp(
            initialRoute: preferences.getBool('sccess') ?? false
                ? Product_overview_screen
                : auth_screen,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(colorScheme: themeProvider.theme),
            onGenerateRoute: appRouter.generateRoute,
          );
        }),
      ),
    );
  }
}
