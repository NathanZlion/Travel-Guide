import 'package:flutter_bloc/flutter_bloc.dart';

import '../data_provider/api_provider.dart';
import 'destination_event.dart';
import 'destination_state.dart';

class DestinationBloc extends Bloc<DestinationEvent, DestinationState> {
  DestinationBloc() : super(DestinationInitial()) {
    ApiDataProvider apiDataProvider = ApiDataProvider();

    
  }
}
