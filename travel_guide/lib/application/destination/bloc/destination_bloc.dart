import 'package:flutter_bloc/flutter_bloc.dart';
import '../destination.dart';

class DestinationBloc extends Bloc<DestinationEvent, DestinationState> {
  DestinationBloc() : super(DestinationInitial()) {
    ApiDataProvider apiDataProvider = ApiDataProvider();

    on<DestinationListLoadEvent>((event, emit) async {
      emit(DestinationListLoading());
      try {
        final List<Destination> destinations =
            await apiDataProvider.getDestinations(event.name, event.location);

        emit(destinations.isNotEmpty
            ? DestinationListLoaded(destinations)
            : DestinationListEmpty());
      } catch (e) {
        emit(DestinationListError(e.toString()));
      }
    });

    on<DestinationDetailLoadEvent>((event, emit) async {
      emit(DestinationDetailLoading());
      try {
        final destination = await apiDataProvider.getDestination(event.id);
        emit(DestinationDetailLoaded(destination));
      } catch (e) {
        emit(DestinationDetailError(e.toString()));
      }
    });
  }
}
