part of 'cartbloc_bloc.dart';


class CartState extends Equatable {
  List<Item> products;
  double? totalPrice;
  CartState({ this.products=const [],this.totalPrice});
  @override
  List<Object> get props=>[products];
}
class Item {
  final Product product;
  int quantity;

  Item({required this.product, required this.quantity});

  @override
  String toString() {
    return 'Item{product: $product, quantity: $quantity}';
  }
}