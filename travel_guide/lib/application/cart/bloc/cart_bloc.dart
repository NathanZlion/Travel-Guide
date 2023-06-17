import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../local_storage.dart';

import '../cart.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartLoad>((event, emit) async {
      emit(CartLoading());
      try {
        final db = await SQLHelper.openDatabase();
        Cart cart = await getCart(db);
        emit(CartLoaded(cart: cart));
      } catch (e) {
        emit(CartError(message: e.toString()));
      }
    });

    on<CartCheck>((event, emit) async {
      try {
        final db = await SQLHelper.openDatabase();
        final bool isInCart = await SQLHelper.isInCart(db, event.item);
        emit(CartChecked(isInCart: isInCart));
      } catch (e) {
        emit(CartError(message: e.toString()));
      }
    });

    on<CartAdd>((event, emit) async {
      emit(CartLoading());
      try {
        final db = await SQLHelper.openDatabase();
        await SQLHelper.addItem(db, event.item);
        Cart cart = await getCart(db);
        emit(CartLoaded(cart: cart));
      } catch (e) {
        emit(CartError(message: e.toString()));
      }
    });

    on<CartRemove>((event, emit) async {
      emit(CartLoading());
      try {
        final db = await SQLHelper.openDatabase();
        await SQLHelper.removeItem(db, event.item);
        Cart cart = await getCart(db);
        emit(CartLoaded(cart: cart));
      } catch (e) {
        emit(CartError(message: e.toString()));
      }
    });
  }

  Future<Cart> getCart(database) async {
    Cart cart = Cart(hotels: [], restaurants: [], destinations: []);
    cart.hotels = await SQLHelper.getHotels(database);
    cart.restaurants = await SQLHelper.getRestaurants(database);
    cart.destinations = await SQLHelper.getDestinations(database);
    return cart;
  }
}
