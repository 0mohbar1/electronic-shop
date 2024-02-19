part of 'showproduct_bloc.dart';

@immutable
abstract class ShowProductEvent {}
class GetAllItem extends ShowProductEvent{}
class AddProductEvent extends ShowProductEvent{
   ApiShopping product;
   AddProductEvent({required this.product});
}