
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

  const DestinationListLoaded(this.destinations);

  @override
  List<Object> get props => [destinations];
}

class DestinationListError extends DestinationState {
  final String message;

  const DestinationListError(this.message);

  @override
  List<Object> get props => [message];
}

class DestinationDetailLoading extends DestinationState {}

class DestinationDetailLoaded extends DestinationState {
  final Destination destination;

  const DestinationDetailLoaded(this.destination);

  @override
  List<Object> get props => [destination];
}

class DestinationDetailError extends DestinationState {
  final String message;

  const DestinationDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class DestinationListEmpty extends DestinationState {}
