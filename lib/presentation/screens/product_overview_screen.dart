import 'package:electronic_shop/bloc/authbloc/authbloc_bloc.dart';
import 'package:electronic_shop/data/repository/shopping_repository.dart';
import 'package:electronic_shop/presentation/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    allproduct=[];
    searchForProduct=[];
    BlocProvider.of<ShowProductBloc>(context).add(GetAllItem());
  }

  Widget _buildSearchField() {
    return TextField(
        controller: _searchTextController,
        cursorColor: Theme.of(context).primaryColor,
        decoration: const InputDecoration(
          hintText: 'Find a product',
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

  Widget buildProductList() {
    return ListView.builder(

      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: _searchTextController.text.isEmpty
          ? allproduct?.length
          : searchForProduct?.length,
      itemBuilder: (ctx, index) {
        return ProductItemWidget(
          product: _searchTextController.text.isEmpty
              ? allproduct![index]
              : searchForProduct![index],
        );
      },
    );
  }

  Widget _buildAppBarTitle() {
    return const Text(
      'Store Shop',
      style: TextStyle(color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
         leading:  _isSearching
                     ? const BackButton(
                         color: Colors.white,
                       )
                     : Container(),
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
      ),
      body: BlocBuilder<ShowProductBloc, ShowproductState>(
        builder: (context, state) {
          if (state is LoagingAllItem) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AllItemsLoaded) {
            allproduct=state.AllItem;

            return buildProductList();
          }else {
            return const Center(
              child: Text("No Product", style: TextStyle(fontSize: 25),),
            );
          }
        },
      ),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BlocProvider<CartblocBloc>.value(
                value: BlocProvider.of<CartblocBloc>(context),
                child: const CartScreen(),
              ),
            ),
          );
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
