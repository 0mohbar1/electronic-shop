import 'package:electronic_shop/bloc/authbloc/authbloc_bloc.dart';
import 'package:electronic_shop/bloc/favoritebloc/favorite_bloc.dart';
import 'package:electronic_shop/data/repository/shopping_repository.dart';
import 'package:electronic_shop/presentation/screens/favorite_screen.dart';
import 'package:electronic_shop/presentation/screens/settings_screen.dart';
import 'package:electronic_shop/presentation/screens/user_screen.dart';
import 'package:electronic_shop/presentation/widgets/drawer.dart';
import 'package:electronic_shop/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import '../../bloc/cartbloc/cartbloc_bloc.dart';
import '../../bloc/showproductbloc/showproduct_bloc.dart';
import '../../data/models/apishopping.dart';
import '../widgets/ptoduct_item_widget.dart';
import 'cart_screen.dart';

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  late List<ApiShopping>? allproduct;
  late List<ApiShopping>? searchForProduct;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    allproduct = [];
    searchForProduct = [];
    BlocProvider.of<ShowProductBloc>(context).add(GetAllItem());
  }

  Widget _buildSearchField() {
    return TextField(
        controller: _searchTextController,
        cursorColor: Theme.of(context).primaryColor,
        decoration: const InputDecoration(
          hintText: 'ابحث عن المنتج',
          border: InputBorder.none,
          hintStyle: TextStyle(fontSize: 18, color: Colors.white),
        ),
        style: const TextStyle(fontSize: 18, color: Colors.white),
        onChanged: (searchForProduct) {
          addSearchedFOrItemsToSearchedList(searchForProduct);
        });
  }

  void addSearchedFOrItemsToSearchedList(String searchedProduct) {
    searchForProduct = allproduct
        ?.where((product) =>
            product.title!.toLowerCase().startsWith(searchedProduct))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: Icon(Icons.clear, color: Theme.of(context).primaryColor),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  Widget _buildAppBarTitle() {
    return const Text(
      'المتجر التقني',
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    );
  }

  Widget buildProductList() {
    return Scaffold(
      backgroundColor:  Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ThemeProvider.primColor,
        leading: _isSearching
            ? const BackButton(
                color: Colors.white,
              )
            : Container(),
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
      ),
      body: GridView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200, // Number of columns in the grid
          childAspectRatio: 0.50,
          //  mainAxisSpacing: 8.0, // Vertical spacing between items
          crossAxisSpacing: 8.0, // Horizontal spacing between items
        ),
        itemCount: _searchTextController.text.isEmpty
            ? allproduct?.length
            : searchForProduct?.length,
        itemBuilder: (ctx, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ProductItemWidget(
              index: index,
              product: _searchTextController.text.isEmpty
                  ? allproduct![index]
                  : searchForProduct![index],
            ),
          );
        },
      ),
    );
  }

  int _selectedPage = 0;

  void _onTabChange(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  List<GButton> tabs = [
    GButton(
      icon: Icons.shopping_bag_outlined,
      text: 'Shop',
      textStyle: TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
    ),
    GButton(
      icon: Icons.shopping_cart,
      text: 'Shop',
      textStyle: TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
    ),
    GButton(
      icon: Icons.assignment_ind,
      text: 'My Info',
      textStyle: TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
    ),
    GButton(
      icon: Icons.favorite,
      text: 'Settings',
      iconColor: Colors.white,
      textStyle: TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      BlocBuilder<ShowProductBloc, ShowproductState>(
        builder: (context, state) {
          if (state is LoagingAllItem) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AllItemsLoaded) {
            allproduct = state.AllItem;
            return buildProductList();
          } else {
            return const Center(
              child: Text(
                "No Product",
                style: TextStyle(fontSize: 25),
              ),
            );
          }
        },
      ),
      BlocProvider<CartblocBloc>.value(
        value: BlocProvider.of<CartblocBloc>(context),
        child: const CartScreen(),
      ),
      UserScreen(),
      // const SettingsScreen()
      BlocProvider<FavoriteBloc>.value(
        value: context.read<FavoriteBloc>(),
        child: FavoriteScreen(),
      ),
    ];
    return Scaffold(
      //  backgroundColor: Colors.black,

      body: _widgetOptions.elementAt(_selectedPage),
      // drawer: const AppDrawer(),
      //  floatingActionButton: FloatingActionButton(
      //    backgroundColor: Theme.of(context).primaryColor,
      //    onPressed: () {
      //      Navigator.of(context).push(
      //        MaterialPageRoute(
      //          builder: (_) => BlocProvider<CartblocBloc>.value(
      //            value: BlocProvider.of<CartblocBloc>(context),
      //            child: const CartScreen(),
      //          ),
      //        ),
      //      );
      //    },
      //    child: const Icon(Icons.shopping_cart),
      //  ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: GNav(
            onTabChange: _onTabChange,
            selectedIndex: _selectedPage,
            haptic: true,
            tabBorderRadius: 50,
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 400),
            iconSize: 20,
            tabBackgroundColor: ThemeProvider.primColor,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            activeColor: Colors.white,
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            gap: 8,
            tabs: tabs,
          ),
        ),
      ),
    );
  }
}
