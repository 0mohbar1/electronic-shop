import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:electronic_shop/data/models/apishopping.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'favorite_event.dart';

part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteState()) {
    on<AddtoFavoriteEvent>((event, emit) {
      final List<Product> list = List.from(state.products)
        ..add(event.product);
      emit(FavoriteState(products: list));
    });

    on<RemoveFromFavoriteEvent>((event, emit) {
      final List<Product> list = List.from(state.products)
        ..removeWhere((product) => product.id == event.id);
      emit(FavoriteState(products: list));
    });
  }
}
