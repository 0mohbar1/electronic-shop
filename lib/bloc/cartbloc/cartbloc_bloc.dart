import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/models/apishopping.dart';
import '../../data/repository/shopping_repository.dart';

part 'cartbloc_event.dart';

part 'cartbloc_state.dart';

class CartblocBloc extends Bloc<CartEvent, CartState> {
  final StoreShoppingRepository storeShoppingRepository;


  CartblocBloc(this.storeShoppingRepository) : super(CartState()) {
    on<AddtoCartEvent>((event, emit) {
      final List<ApiShopping> list = List.from(state.products)
        ..add(event.product);
      emit(CartState(products: list));
    });
  }
}
