
class EventsEntity {
  String event_name;
  String description;
  String start_date;
  String end_date;
  String location_id;
  String organizer_id;

  EventsEntity({
    required this.event_name,
    required this.description,
    required this.start_date,
    required this.end_date,
    required this.location_id,
    required this.organizer_id});

  factory EventsEntity.fromJson(Map<String, dynamic> json){
    try {
      return EventsEntity(
          event_name: json["event_name"] ?? "Kosong",
          description: json["description"] ?? "Kosong",
          start_date: json["start_date"].toString() ?? "Kosong",
          end_date: json["end_date"].toString() ?? "Kosong",
          location_id: json["location_id"].toString() ?? "Kosong",
          organizer_id: json["organizer_id"].toString() ?? "Kosong");
    }
    catch (e) {
      throw const FormatException('Gagal membuat events');
    }
  }
  String toString(){
    return
        "${event_name},""${description},""${start_date},""${end_date},""${location_id},""${organizer_id},";
  }

}