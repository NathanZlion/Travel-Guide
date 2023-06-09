import 'package:equatable/equatable.dart';

import '../hotel.dart';


abstract class HotelState extends Equatable {
  const HotelState();

  @override
  List<Object> get props => [];
}

class HotelInitial extends HotelState {}

class HotelListLoading extends HotelState {}

class HotelListLoaded extends HotelState {
  final List<Hotel> hotels;

  const HotelListLoaded(this.hotels);

  @override
  List<Object> get props => [hotels];
}

class HotelListError extends HotelState {
  final String message;

  const HotelListError(this.message);

  @override
  List<Object> get props => [message];
}

class HotelDetailLoading extends HotelState {}

class HotelDetailLoaded extends HotelState {
  final Hotel hotel;

  const HotelDetailLoaded(this.hotel);

  @override
  List<Object> get props => [Hotel];
}

class HotelDetailError extends HotelState {
  final String message;

  const HotelDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class HotelListEmpty extends HotelState {}
