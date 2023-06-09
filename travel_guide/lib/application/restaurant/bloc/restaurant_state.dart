
import 'package:equatable/equatable.dart';

import '../restaurant.dart';


abstract class RestaurantState extends Equatable {
  const RestaurantState();

  @override
  List<Object> get props => [];
}

class RestaurantInitial extends RestaurantState {}

class RestaurantListLoading extends RestaurantState {}

class RestaurantListLoaded extends RestaurantState {
  final List<Restaurant> restaurants;

  const RestaurantListLoaded(this.restaurants);

  @override
  List<Object> get props => [restaurants];
}

class RestaurantListError extends RestaurantState {
  final String message;

  const RestaurantListError(this.message);

  @override
  List<Object> get props => [message];
}

class RestaurantDetailLoading extends RestaurantState {}

class RestaurantDetailLoaded extends RestaurantState {
  final Restaurant restaurant;

  const RestaurantDetailLoaded(this.restaurant);

  @override
  List<Object> get props => [Restaurant];
}

class RestaurantDetailError extends RestaurantState {
  final String message;

  const RestaurantDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class RestaurantListEmpty extends RestaurantState {}
