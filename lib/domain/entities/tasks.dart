
class TasksEntity {
  String event_id;
  String description;
  String deadline;
  String status;

  TasksEntity({
    required this.event_id,
    required this.description,
    required this.deadline,
    required this.status,});

  factory TasksEntity.fromJson(Map<String, dynamic> json){
    try {
      return TasksEntity(
          event_id: json["event_id"].toString() ?? "Kosong",
          description: json["description"] ?? "Kosong",
          deadline: json["deadline"].toString() ?? "Kosong",
          status: json["status"].toString() ?? "Kosong",);
    }
    catch (e) {
      throw const FormatException('Gagal membuat tasks');
    }
  }
  String toString(){
    return
      "${event_id},""${description},""${deadline},""${status},";
  }
}