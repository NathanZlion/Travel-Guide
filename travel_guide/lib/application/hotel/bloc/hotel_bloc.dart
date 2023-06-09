import 'package:flutter_bloc/flutter_bloc.dart';
import '../hotel.dart';

class HotelBloc extends Bloc<HotelEvent, HotelState> {
  HotelBloc() : super(HotelInitial()) {
    ApiDataProvider apiDataProvider = ApiDataProvider();

    on<HotelListLoadEvent>((event, emit) async {
      emit(HotelListLoading());

      try {
        final List<Hotel> hotels =
            await apiDataProvider.getHotels(event.name, event.location);

        emit(hotels.isNotEmpty ? HotelListLoaded(hotels) : HotelListEmpty());
      } catch (e) {
        emit(HotelListError(e.toString()));
      }
    });

    on<HotelDetailLoadEvent>((event, emit) async {
      emit(HotelDetailLoading());
      try {
        final Hotel hotel = await apiDataProvider.getHotel(event.id);
        emit(HotelDetailLoaded(hotel));
      } catch (e) {
        emit(HotelDetailError(e.toString()));
      }
    });
  }
}
