import 'dart:convert';

class AssignedTask {
  int id;
  String task_name;
  String description;
  String latitude;
  String longitude;
  String status;
  int user_id;

  AssignedTask(
      {this.id,
      this.task_name,
      this.description,
      this.latitude,
      this.longitude,
      this.status,
      this.user_id});

  factory AssignedTask.formJson(Map<String, dynamic> map) {
    return AssignedTask(
      id: map["id"],
      task_name: map["task_name"],
      description: map["description"],
      latitude: map["latitude"],
      longitude: map["longitude"],
      status: map["status"],
      user_id: map["user_id"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "task_name": task_name,
      "description": description,
      "latitude": latitude,
      "longitude": longitude,
      "user_id": user_id
    };
  }

  @override
  String toString() {
    return 'AssignedTask{id: $id, task_name: $task_name, description: $description, latitude: $latitude,longitude: $longitude,status: $status, user_id: $user_id}';
  }
}

List<AssignedTask> assignedTaskFromJson(String jsonData) {
  final taskdata = json.decode(jsonData);
  return List<AssignedTask>.from(
      taskdata.map((item) => AssignedTask.formJson(item)));
}

String assignedTaskToJson(AssignedTask taskdata) {
  final jsonData = taskdata.toJson();
  return json.encode(jsonData);
}
