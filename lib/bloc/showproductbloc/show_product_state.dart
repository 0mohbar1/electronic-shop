part of 'showproduct_bloc.dart';

@immutable
abstract class ShowproductState extends Equatable {
  @override
  List<Object> get props=>[];
}

class ShowproductInitial extends ShowproductState {}
class LoagingAllItem extends ShowproductState{}
class AllItemsLoaded extends ShowproductState{
  final List<ApiShopping> AllItem;

  AllItemsLoaded(this.AllItem);
  @override
  List<Object> get props=>[AllItem];
}
class FailedToLoadItems extends ShowproductState{
  final String message;

  FailedToLoadItems(this.message);
  @override
  List<Object> get props=>[message];
}
class CartState extends ShowproductState{
  List<ApiShopping> products;
  CartState({required this.products});
}