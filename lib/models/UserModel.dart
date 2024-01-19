class UserModel {
  UserModel({
      this.id, 
      this.name, 
      this.email, 
      this.password,
  this.img});

  UserModel.fromJson(dynamic json) {
    id = json['Id'];
    name = json['Name'];
    email = json['Email'];
    password = json['Password'];
    img = json['Img'];
  }
  int? id;
  String? name;
  String? email;
  String? password;
  String? img;
UserModel copyWith({  int? id,
  String? name,
  String? email,
  String? password,
  String? img,
}) => UserModel(  id: id ?? this.id,
  name: name ?? this.name,
  email: email ?? this.email,
  password: password ?? this.password,
  img: img ?? this.img,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = id;
    map['Name'] = name;
    map['Email'] = email;
    map['Password'] = password;
    map['Img'] = img;
    return map;
  }

}