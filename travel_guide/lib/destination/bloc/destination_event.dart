

import 'package:equatable/equatable.dart';

abstract class DestinationEvent extends Equatable {
  const DestinationEvent();

  @override
  List<Object> get props => [];
}

class DestinationListLoading extends DestinationEvent {}

class DestinationListLoadingSuccess extends DestinationEvent {}

class DestinationListloadingFailure extends DestinationEvent {}

class DestinationDetailsLoading extends DestinationEvent {}

class DestinationDetailsLoadingSuccess extends DestinationEvent {}

class DestinationDetailsLoadingFailure extends DestinationEvent {}

