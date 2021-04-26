// To parse this JSON data, do
//
//     final facebookParsJson = facebookParsJsonFromJson(jsonString);

import 'dart:convert';

FacebookParsJson facebookParsJsonFromJson(String str) =>
    FacebookParsJson.fromJson(json.decode(str));

String facebookParsJsonToJson(FacebookParsJson data) =>
    json.encode(data.toJson());

class FacebookParsJson {
  FacebookParsJson({
    this.name,
    this.firstName,
    this.lastName,
    this.email,
    this.picture,
    this.id,
  });

  String name;
  String firstName;
  String lastName;
  String email;
  Picture picture;
  String id;

  factory FacebookParsJson.fromJson(Map<String, dynamic> json) =>
      FacebookParsJson(
        name: json["name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        picture: Picture.fromJson(json["picture"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "picture": picture.toJson(),
        "id": id,
      };
}

class Picture {
  Picture({
    this.data,
  });

  Data data;

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.height,
    this.isSilhouette,
    this.url,
    this.width,
  });

  int height;
  bool isSilhouette;
  String url;
  int width;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        height: json["height"],
        isSilhouette: json["is_silhouette"],
        url: json["url"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "is_silhouette": isSilhouette,
        "url": url,
        "width": width,
      };
}
