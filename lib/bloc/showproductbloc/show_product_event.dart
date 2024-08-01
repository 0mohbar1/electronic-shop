part of 'showproduct_bloc.dart';

@immutable
abstract class ShowProductEvent {}
class GetAllItem extends ShowProductEvent{}
class AddProductEvent extends ShowProductEvent{
   ApiShopping product;
   AddProductEvent({required this.product});
}
class ShowIconFavorite extends ShowProductEvent{
   final int index;
   final bool isFav;

  ShowIconFavorite({required this.index, required this.isFav});
}

class UnShowIconFavorite extends ShowProductEvent{
  final int index;
  final bool isFav;

  UnShowIconFavorite({required this.index, required this.isFav});
}
