import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../data/models/apishopping.dart';
import '../../data/repository/shopping_repository.dart';
part  'show_product_event.dart';
part  'show_product_state.dart';

class ShowProductBloc extends Bloc<ShowProductEvent, ShowproductState> {
  final StoreShoppingRepository storeShoppingRepository;

  List<ApiShopping> allItems = [];

  ShowProductBloc(this.storeShoppingRepository) : super(ShowproductInitial()) {
    on<GetAllItem>((event, emit) async {
      emit(LoagingAllItem());
      try {
        final List<ApiShopping> allItems =
            await storeShoppingRepository.getAllItem();
        emit(AllItemsLoaded(allItems));
      } catch (e) {
        emit(FailedToLoadItems(e.toString()));
      }
    });


  }
}
