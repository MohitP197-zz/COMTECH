import 'dart:convert';

class Office{
  int id;
  String office_name;
  String description;
  String location;
  int task_id;
  int user_id;

  Office({this.id, this.office_name, this.description, this.location, this.task_id, this.user_id});

  factory Office.fromJson (Map<String, dynamic> map){
    return Office(
      id: map["id"],
      office_name: map["office_name"],
      description: map["description"],
      location: map["location"],
      task_id: map["task_id"],
      user_id: map["user_id"],
    );
  }

  Map<String, dynamic> toJson(){
    return {"id":id, "office_name":office_name, "description":description,"location":location,"task_id":task_id,"user_id":user_id};

    // return 'Office {id:$id, office_name:$office_name, description:$description,location:$location,task_id:$task_id,user_id:$user_id}';
  }
}

List<Office> officeFromJson(String jsonData){
  final officedata = json.decode(jsonData);
  return List<Office>.from(officedata.map ((item) => Office.fromJson(item)));
}

String officeToJson(Office data){
  final officeData = data.toJson();
  return json.encode(officeData);
}