import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_guide/infrastructure/cart/api_provider.dart';

import '../../destination/model/destination_model.dart';
import '../../hotel/model/hotel_model.dart';
import '../../restaurant/model/restaurant_model.dart';
import '../cart.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    CartCache cache = CartCache();

    on<CartLoad>((event, emit) async {
      emit(CartLoading());
      try {
        Cart cart = await cache.getCart();
        emit(CartLoaded(cart: cart));
      } catch (e) {
        emit(CartError(message: e.toString()));
      }
    });

    on<CartAdd>((event, emit) async {
      emit(CartLoading());
      try {
        Cart cart;
        if (event.item is Hotel) {
          Hotel item = event.item as Hotel;
          cart = await cache.addHotel(item.id);
        } else if (event.item is Restaurant) {
          Restaurant item = event.item as Restaurant;
          cart = await cache.addRestaurant(item.id);
        } else {
          Destination item = event.item as Destination;
          cart = await cache.addDestination(item.id);
        }

        Cart cartNew = await cache.getCart();
        emit(CartLoaded(cart: cartNew));
      } catch (e) {
        emit(CartError(message: e.toString()));
      }
    });

    on<CartRemove>((event, emit) async {
      emit(CartLoading());
      try {
        Cart cart;
        if (event.item is Hotel) {
          Hotel item = event.item as Hotel;
          cart = await cache.removeHotel(item.id);
        } else if (event.item is Restaurant) {
          Restaurant item = event.item as Restaurant;
          cart = await cache.removeRestaurant(item.id);
        } else {
          Destination item = event.item as Destination;
          cart = await cache.removeDestination(item.id);
        }

        Cart cartNew = await cache.getCart();
        emit(CartLoaded(cart: cartNew));
      } catch (e) {
        emit(CartError(message: e.toString()));
      }
    });

    on<ClearCartEvent>((event, emit) async {
      emit(CartLoading());
      try {
        Cart cart = await cache.clearCart();
        print("clear cart");
        print(cart.destinations);
        print(cart.hotels);
        print(cart.restaurants);
        emit(CartLoaded(cart: cart));
      } catch (e) {
        emit(CartError(message: e.toString()));
      }
    });
  }
}
