
import '../cart.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final Cart cart;

  CartLoaded({required this.cart});
}

class CartError extends CartState {
  final String message;

  CartError({required this.message});
}

class CartChecked extends CartState {
  final bool isInCart;

  CartChecked({required this.isInCart});
}
