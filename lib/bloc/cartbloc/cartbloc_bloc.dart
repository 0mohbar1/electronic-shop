import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/models/apishopping.dart';
import '../../data/repository/shopping_repository.dart';

part 'cartbloc_event.dart';

part 'cartbloc_state.dart';

class CartblocBloc extends Bloc<CartEvent, CartState> {
  //final StoreShoppingRepository storeShoppingRepository;
  double total = 0;

  CartblocBloc() : super(CartState()) {
    on<BuyOneItem>(_onBuyOneItem);
    on<BuyAllItem>(_onBuyAllItem);
    on<AddtoCartEvent>((event, emit) {

      total +=event.totalPrice;
      if (state.products
          .any((element) => element.product.name == event.product.name)) {
        for (var item in state.products) {
          if (item.product.name == event.product.name) {
            emit(CartState(
                products: List.of(state.products)
                  ..[state.products.indexWhere((element) =>
                          element.product.name == event.product.name)] =
                      Item(
                          product: item.product, quantity: item.quantity + 1,),totalPrice: total,),);
          }
        }
      } else {
        emit(
          CartState(
              products: List.of(state.products)
                ..add(
                  Item(product: event.product, quantity: 1),
                ),
              totalPrice: total),
        );
      }
    });
  }

  void _onBuyOneItem(BuyOneItem event, Emitter<CartState> emit) {
    final List<Item> updatedList = List.from(state.products)
      ..removeWhere((element) => element.product.id == event.id);

    emit(CartState(products: updatedList));
  }

  void _onBuyAllItem(BuyAllItem event, Emitter<CartState> emit) {
    final List<Item> updatedList = List.from(state.products)..clear();
    total = 0;
    emit(CartState(products: updatedList, totalPrice: total));
  }
}
