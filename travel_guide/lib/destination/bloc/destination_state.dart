// DestinationState
// Path: travel_guide\lib\destination\bloc\destination_state.dart
// Compare this snippet from travel_guide\lib\destination\bloc\destination_event.dart:
//
//

import 'package:equatable/equatable.dart';

import '../model/destination_model.dart';

abstract class DestinationState extends Equatable {
  const DestinationState();

  @override
  List<Object> get props => [];
}

class DestinationInitial extends DestinationState {}

class DestinationListLoading extends DestinationState {}

class DestinationListLoaded extends DestinationState {
  final List<Destination> destinations;

  const DestinationListLoaded([this.destinations = const []]);

  @override
  List<Object> get props => [destinations];

  @override
  String toString() => 'DestinationLoaded { destinations: $destinations }';
}

class DestinationListError extends DestinationState {
  final String message;

  const DestinationListError(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'DestinationError { message: $message }';
}

class DestinationDetailLoading extends DestinationState {}

class DestinationDetailLoaded extends DestinationState {
  final List<Destination> destinations;

  const DestinationDetailLoaded([this.destinations = const []]);

  @override
  List<Object> get props => [destinations];

  @override
  String toString() => 'DestinationLoaded { destinations: $destinations }';
}

class DestinationDetailError extends DestinationState {
  final String message;

  const DestinationDetailError(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'DestinationError { message: $message }';
}

