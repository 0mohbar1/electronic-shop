part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteEvent {}
class AddtoFavoriteEvent extends FavoriteEvent{
  Product product;
  AddtoFavoriteEvent({required this.product});
}
class RemoveFromFavoriteEvent extends FavoriteEvent{
  final int id;
  RemoveFromFavoriteEvent({required this.id});
}