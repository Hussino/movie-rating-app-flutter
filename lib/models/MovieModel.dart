class MovieModel {
  MovieModel({
      this.id, 
      this.name, 
      this.img, 
      this.details,});

  MovieModel.fromJson(dynamic json) {
    id = json['Id'];
    name = json['Name'];
    img = json['Img'];
    details = json['Details'];
  }
  int? id;
  String? name;
  String? img;
  String? details;
MovieModel copyWith({  int? id,
  String? name,
  String? img,
  String? details,
}) => MovieModel(  id: id ?? this.id,
  name: name ?? this.name,
  img: img ?? this.img,
  details: details ?? this.details,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = id;
    map['Name'] = name;
    map['Img'] = img;
    map['Details'] = details;
    return map;
  }

}