part of 'favorite_bloc.dart';

class FavoriteState extends Equatable {
  List<Product> products;

  FavoriteState({this.products = const [], });

  FavoriteState copyWith({bool? isProductFavorite}) {
    return FavoriteState(
      products: products,

    );
  }

  @override
  List<Object> get props => [products];
}
