import 'dart:convert'; 

class FeedBackModel { 
  int id; 
  String name; 
  String feedb; 

  FeedBackModel ({ this .id = 0, this. name, this. feedb,}); 

  factory FeedBackModel.fromJson (Map <String, dynamic > map) { 
    return FeedBackModel ( 
        id: map ["id"], name: map ["name"], feedb: map ["feedb"]); 
  } 

  Map <String, dynamic > toJson () { 
    return {"id": id, "name": name, "feedb":feedb};

    // return 'Profile {id: $ id, name: $ name, email: $ email, age: $ age}'; 
  } 

} 

List <FeedBackModel> feedBackModelFromJson (String jsonData) { 
  final data = json.decode (jsonData); 
  return List <FeedBackModel> .from (data.map ((item) => FeedBackModel.fromJson (item))); 
} 

String feedBackModelToJson (FeedBackModel data) { 
  final jsonData = data.toJson (); 
  return json.encode (jsonData); 
}