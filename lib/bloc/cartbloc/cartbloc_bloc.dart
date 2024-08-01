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

  CartblocBloc() : super(CartState()) {
    on<BuyOneItem>(_onBuyOneItem);
    on<BuyAllItem>(_onBuyAllItem);
    on<AddtoCartEvent>((event, emit) {
      final List<ApiShopping> list = List.from(state.products)
        ..add(event.product);
      emit(CartState(products: list));
    });
  }

  void _onBuyOneItem(BuyOneItem event, Emitter<CartState> emit) {
    final List<ApiShopping> updatedList = List.from(state.products)
      ..removeWhere((element) => element.id == event.id);
    emit(CartState(products: updatedList));
  }

  void _onBuyAllItem(BuyAllItem event, Emitter<CartState> emit) {
    final List<ApiShopping> updatedList = List.from(state.products)..clear();
    emit(CartState(products: updatedList));
  }
}
