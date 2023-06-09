abstract class HotelEvent {
  const HotelEvent();
}

class HotelListLoadEvent extends HotelEvent {
  final String name;
  final String location;

  const HotelListLoadEvent(this.location, this.name);
}

class HotelDetailLoadEvent extends HotelEvent {
  final String id;

  const HotelDetailLoadEvent(this.id);
}
