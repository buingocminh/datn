

class UserModel {
  String id;
  String name;
  String email;
  List<String> favoritePlaces;

  UserModel({required this.id, required this.name, required this.email, required this.favoritePlaces});

  Map<String,dynamic> get toJson => {
    "id" : id,
    "email" : email,
    "name" : name,
    "favoritePlaces" : favoritePlaces
  };
}
