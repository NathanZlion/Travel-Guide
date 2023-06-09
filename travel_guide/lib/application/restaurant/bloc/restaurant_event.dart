abstract class RestaurantEvent {
  const RestaurantEvent();
}

class RestaurantListLoadEvent extends RestaurantEvent {
  final String name;
  final String location;

  const RestaurantListLoadEvent(this.name, this.location);
}

class RestaurantDetailLoadEvent extends RestaurantEvent {
  final String id;

  const RestaurantDetailLoadEvent(this.id);
}
