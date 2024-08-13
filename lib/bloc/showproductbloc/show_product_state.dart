part of 'showproduct_bloc.dart';

@immutable
abstract class ShowproductState  {

}

class ShowproductInitial extends ShowproductState {}
class LoagingAllItem extends ShowproductState{}
class AllItemsLoaded extends ShowproductState{
  final List<Product> AllItem;

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
  List<Product> products;
  CartState({required this.products});
}