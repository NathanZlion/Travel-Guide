import 'package:flutter_bloc/flutter_bloc.dart';
import '../restaurant.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  RestaurantBloc() : super(RestaurantInitial()) {
    ApiDataProvider apiDataProvider = ApiDataProvider();

    on<RestaurantListLoadEvent>((event, emit) async {
      emit(RestaurantListLoading());
      try {
        final List<Restaurant> restaurants =
            await apiDataProvider.getRestaurants(event.name, event.location);
        emit(restaurants.isNotEmpty
            ? RestaurantListLoaded(restaurants)
            : RestaurantListEmpty());
      } catch (e) {
        emit(RestaurantListError(e.toString()));
      }
    });

    on<RestaurantDetailLoadEvent>((event, emit) async {
      emit(RestaurantDetailLoading());
      try {
        final restaurant = await apiDataProvider.getRestaurant(event.id);
        emit(RestaurantDetailLoaded(restaurant));
      } catch (e) {
        emit(RestaurantDetailError(e.toString()));
      }
    });
  }
}
