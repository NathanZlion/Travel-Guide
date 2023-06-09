abstract class DestinationEvent {
  const DestinationEvent();
}

class DestinationListLoadEvent extends DestinationEvent {
  final String name;
  final String location;

  const DestinationListLoadEvent(this.name, this.location);
}

class DestinationDetailLoadEvent extends DestinationEvent {
  final String id;

  const DestinationDetailLoadEvent(this.id);
}
