import 'dart:convert'; 

class FeedBackModel { 
  int id; 
  String title;
  String user_name; 
  String description; 

  FeedBackModel ({ this .id = 0, this.title,this.user_name, this.description}); 

  factory FeedBackModel.fromJson (Map <String, dynamic > map) { 
    return FeedBackModel ( 
        id: map ["id"], title: map ["title"], user_name: map ["user_name"], description: map ["description"]); 
  } 

  Map <String, dynamic > toJson () { 
    return {"id": id, "title": title, "user_name": user_name, "description":description};

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