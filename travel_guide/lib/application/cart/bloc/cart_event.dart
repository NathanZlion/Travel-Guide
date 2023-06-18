


abstract class CartEvent {}

class CartLoad extends CartEvent {}

class CartCheck extends CartEvent {
  final Object item;

  CartCheck({required this.item});
}

class CartAdd extends CartEvent {
  final Object item;

  CartAdd({required this.item});
}

class CartRemove extends CartEvent {
  final Object item;

  CartRemove({required this.item});
}


class ClearCartEvent extends CartEvent {}

